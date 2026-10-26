# Adopt running workers; validate source coverage and outputs before advancing.
# Windows ExitCode may be null; existence or size alone never establishes completion.
param(
    [string[]]$Participants = @('P11','P12','P13','P14','P15','P16','P17'),
    [int]$BatchSize = 7,
    [string]$Python = '',
    [switch]$AllowKnownGaps = $true,
    [int]$MaxKnownGapFrames = 50
)
$ErrorActionPreference = 'Stop'
$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$LogRoot = Join-Path $ProjectRoot 'output\SVF Output'
$MasterLog = Join-Path $LogRoot 'camup_sequential_queue.log'
$CamUp = Join-Path $PSScriptRoot 'compute_svf_camup.py'
$EnvRoot = Join-Path $ProjectRoot 'temp\tf_dml_venv'
if (!$Python) { $Python = Join-Path $EnvRoot 'Scripts\python.exe' }
$RawRoot = 'C:\Users\pandya\OneDrive - UCL\Field experiment raw data\Complete Participantwise data\Final Data\ucm'
$Culture = [Globalization.CultureInfo]::InvariantCulture

function Write-Log([string]$Message) {
    $line = '[{0}] {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    Add-Content -LiteralPath $MasterLog -Value $line
    Write-Host $line
}

function Test-CamUpComplete([string]$Participant, [switch]$QueueMode) {
    try {
        $script:GapFrames = 0
        $dir = Join-Path $LogRoot $Participant
        $fullPath = Join-Path $dir "${Participant}_SVF.csv"
        $matchedPath = Join-Path $dir "${Participant}_SVF_matched_8min.csv"
        if (!(Test-Path -LiteralPath $fullPath) -or !(Test-Path -LiteralPath $matchedPath)) { throw 'Full or matched final CSV missing' }
        $key = @($KeyRows | Where-Object { ('P' + $_.Participant_ID.Trim().TrimStart('P')) -eq $Participant })
        if ($key.Count -ne 1) { throw 'Participant key must resolve exactly once' }
        $expected = [Collections.Generic.HashSet[string]]::new()
        $matchedExpected = [Collections.Generic.HashSet[string]]::new()
        foreach ($phase in @('BikeG','BikeU','WalkG','WalkU','Tram')) {
            $source = Join-Path $RawRoot "$Participant\$phase\ucm"
            $sessions = @()
            if (Test-Path -LiteralPath (Join-Path $source 'CamUp')) { $sessions += $source }
            $sessions += @(Get-ChildItem -LiteralPath $source -Directory | Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'CamUp') } | ForEach-Object FullName)
            if ($sessions.Count -ne 1) { throw "Ambiguous/missing raw source for $phase" }
            $images = @(Get-ChildItem -LiteralPath (Join-Path $sessions[0] 'CamUp') -File | Where-Object { $_.Name -match '^cam_\d{8}_\d{6}\.(jpg|jpeg|png)$' } | Sort-Object Name)
            if (!$images.Count) { throw "No images for $phase" }
            $year = $images[0].Name.Substring(4,4)
            $date = [datetime]::ParseExact("$year-$($key[0].Date)", 'yyyy-dd-MMM', $Culture)
            $start = $date.Add([timespan]::Parse($key[0]."${phase}_start", $Culture))
            $end = $date.Add([timespan]::Parse($key[0]."${phase}_end", $Culture))
            if ($end -le $start) { $end = $end.AddDays(1) }
            $phaseCount = 0
            foreach ($image in $images) {
                $time = [datetime]::ParseExact($image.BaseName.Substring(4), 'yyyyMMdd_HHmmss', $Culture)
                if ($time -ge $start -and $time -lt $end) {
                    [void]$expected.Add("$phase|$($image.Name)")
                    $phaseCount++
                    if ($time -lt $start.AddSeconds(480)) { [void]$matchedExpected.Add("$phase|$($image.Name)") }
                }
            }
            if (!$phaseCount) { throw "No keyed images for $phase" }
        }
        $full = @(Import-Csv -LiteralPath $fullPath)
        $matched = @(Import-Csv -LiteralPath $matchedPath)
        if ($full.Count -gt $expected.Count) { throw 'CSV has more rows than keyed source frames' }
        if ($QueueMode) {
            $script:GapFrames = $expected.Count - $full.Count
            if ($script:GapFrames -gt $MaxKnownGapFrames) {
                throw "CSV missing $script:GapFrames keyed frames (queue limit $MaxKnownGapFrames)"
            }
            if ($matched.Count -gt $matchedExpected.Count) { throw 'Matched CSV has more rows than keyed 8-min windows' }
        } elseif ($full.Count -ne $expected.Count -or $matched.Count -ne $matchedExpected.Count) {
            throw 'CSV counts differ from keyed source frames'
        }
        $byKey = @{}
        $signatures = [Collections.Generic.HashSet[string]]::new()
        foreach ($row in $full) {
            $k = "$($row.PhaseID)|$($row.Filename)"
            if (!$expected.Contains($k) -or $byKey.ContainsKey($k)) { throw "Unexpected/duplicate frame $k" }
            if ($row.ParticipantID -ne $Participant -or $row.Camera -ne 'CamUp' -or $row.Model -ne 'DeepLabV3+_Xception65_ADE20K' -or $row.Model_SHA256 -ne $ModelHash) { throw 'Participant/model provenance mismatch' }
            if (!$row.Run_Config_Signature) { throw 'Missing run configuration signature' }
            [void]$signatures.Add($row.Run_Config_Signature)
            foreach ($factor in @('SVF','TVF','BVF')) {
                $number = 0.0
                if (![double]::TryParse($row.$factor, [Globalization.NumberStyles]::Float, $Culture, [ref]$number) -or [double]::IsNaN($number) -or [double]::IsInfinity($number) -or $number -lt 0 -or $number -gt 1) { throw "Invalid $factor for $k" }
            }
            $byKey[$k] = $row
        }
        if ($signatures.Count -ne 1) { throw 'Mixed run configurations in final CSV' }
        $seen = [Collections.Generic.HashSet[string]]::new()
        foreach ($row in $matched) {
            $k = "$($row.PhaseID)|$($row.Filename)"
            if (!$matchedExpected.Contains($k) -or !$seen.Add($k)) { throw 'Unexpected/duplicate matched frame' }
            foreach ($field in $full[0].PSObject.Properties.Name) {
                if ($row.$field -cne $byKey[$k].$field) { throw "Full/matched mismatch: $k $field" }
            }
        }
        $failurePath = Join-Path $dir "${Participant}_SVF_failures.csv"
        $failureNote = ''
        if (Test-Path -LiteralPath $failurePath) {
            if (!$QueueMode) { throw 'Outstanding failure report exists' }
            $failureNote = "; failures=$(@(Import-Csv -LiteralPath $failurePath).Count) logged in ${Participant}_SVF_failures.csv"
        }
        if ($QueueMode -and $script:GapFrames -gt 0) {
            $script:ValidationReason = "$($full.Count)/$($expected.Count) full / $($matched.Count)/$($matchedExpected.Count) matched; gap=$($script:GapFrames) frames$failureNote (queue OK, review later)"
        } else {
            $script:ValidationReason = "$($full.Count) full / $($matched.Count) matched; exact keys, all five phases and factors validated$failureNote"
        }
        return $true
    } catch { $script:ValidationReason = $_.Exception.Message; return $false }
}

function Wait-CamUpWorkers {
    $lastIds = ''
    while ($true) {
        $workers = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^python.*\.exe$' -and $_.CommandLine -and $_.CommandLine.Contains($CamUp) })
        if (!$workers.Count) { return }
        $ids = ($workers.ProcessId | Sort-Object) -join ','
        if ($ids -ne $lastIds) { Write-Log "Waiting for existing CamUp workers: $ids; no duplicate launch"; $lastIds = $ids }
        Start-Sleep -Seconds 15
    }
}

$mutex = [Threading.Mutex]::new($false, 'Local\Paper3Final_CamUpQueue')
$owned = $false
$queueExit = 0
try {
    try { $owned = $mutex.WaitOne(0) } catch [Threading.AbandonedMutexException] { $owned = $true }
    if (!$owned) { throw 'Another verified queue controller is already running' }
    $Participants = @($Participants | ForEach-Object { $_ -split ',' } | ForEach-Object { $_.Trim().ToUpperInvariant() } | Select-Object -Unique)
    if (!$Participants.Count -or @($Participants | Where-Object { $_ -notmatch '^P\d+$' }).Count) { throw 'Invalid participant list' }
    if ($BatchSize -lt 1) { throw 'Batch size must be positive' }
    foreach ($path in @($Python,$CamUp,(Join-Path $ProjectRoot 'output\key.csv'))) {
        if (!(Test-Path -LiteralPath $path -PathType Leaf)) { throw "Missing required file: $path" }
    }
    $KeyRows = @(Import-Csv -LiteralPath (Join-Path $ProjectRoot 'output\key.csv'))
    $ModelHash = (Get-FileHash -LiteralPath (Join-Path $PSScriptRoot 'deeplabv3_xception65_ade20k.h5') -Algorithm SHA256).Hash.ToLowerInvariant()
    $env:PATH = (Join-Path $EnvRoot 'Lib\site-packages\tensorflow-plugins\directml') + ';' + (Join-Path $EnvRoot 'Lib\site-packages\tensorflow-plugins') + ';' + $env:PATH
    $env:DML_VISIBLE_DEVICES = '0'
    $env:TF_ENABLE_ONEDNN_OPTS = '0'
    $env:TF_CPP_MIN_LOG_LEVEL = '0'
    $env:PYTHONNOUSERSITE = '1'
    Remove-Item Env:PYTHONPATH -ErrorAction SilentlyContinue
    Remove-Item Env:PYTHONHOME -ErrorAction SilentlyContinue
    $queueValidate = { param($p) if ($AllowKnownGaps) { Test-CamUpComplete $p -QueueMode } else { Test-CamUpComplete $p } }
    Write-Log "Verified controller pid=$PID; queue=$($Participants -join ','); Python=$Python; AllowKnownGaps=$AllowKnownGaps; MaxKnownGapFrames=$MaxKnownGapFrames"
    foreach ($participant in $Participants) {
        Wait-CamUpWorkers
        if (& $queueValidate $participant) { Write-Log "SKIP $participant validated: $ValidationReason"; continue }
        Write-Log "Needs processing $participant`: $ValidationReason"
        $outDir = Join-Path $LogRoot $participant
        New-Item -ItemType Directory -Force -Path $outDir | Out-Null
        $runLog = Join-Path $outDir "${participant}_CamUp_GPU_DirectML.log"
        $errLog = Join-Path $outDir "${participant}_CamUp_GPU_DirectML.err.log"
        foreach ($path in @($runLog,$errLog)) {
            if (Test-Path -LiteralPath $path) {
                $archive = Join-Path $ProjectRoot "archive\output\SVF Output\$participant"
                New-Item -ItemType Directory -Force -Path $archive | Out-Null
                Copy-Item -LiteralPath $path -Destination (Join-Path $archive ((Get-Date -Format 'yyyyMMdd_HHmmss') + '_' + [IO.Path]::GetFileName($path)))
            }
        }
        Write-Log "Starting $participant; stdout=$runLog; stderr=$errLog"
        $pyArgs = @('-u', "`"$CamUp`"", '--participant', $participant, '--phase', 'all', '--batch-size', "$BatchSize")
        if ($AllowKnownGaps) { $pyArgs += '--allow-partial' }
        $proc = Start-Process -FilePath $Python -WorkingDirectory $ProjectRoot -PassThru -WindowStyle Hidden `
            -ArgumentList $pyArgs `
            -RedirectStandardOutput $runLog -RedirectStandardError $errLog
        $null = $proc.Handle
        Write-Log "Launched $participant pid=$($proc.Id)"
        $proc.WaitForExit()
        $proc.Refresh()
        $code = $proc.ExitCode
        $codeText = if ($null -eq $code) { 'null' } else { [string]$code }
        Wait-CamUpWorkers
        if (!(& $queueValidate $participant)) {
            throw "$participant incomplete: $ValidationReason; ExitCode=$codeText. See $runLog and $errLog. Resume after resolving the error."
        }
        if ($AllowKnownGaps -and !(Test-CamUpComplete $participant)) {
            Write-Log "WARN $participant queue-advanced with known gaps (strict validation failed): $ValidationReason"
        }
        if ($null -ne $code -and $code -ne 0) { Write-Log "WARN $participant ExitCode=$codeText despite queue-validated outputs" }
        Write-Log "OK $participant ExitCode=$codeText; $ValidationReason"
    }
    Write-Log 'Queue complete: every requested participant validated.'
} catch { $queueExit = 1; Write-Log "STOP with explicit error: $($_.Exception.Message)" }
finally { if ($owned) { $mutex.ReleaseMutex() }; $mutex.Dispose() }
exit $queueExit
