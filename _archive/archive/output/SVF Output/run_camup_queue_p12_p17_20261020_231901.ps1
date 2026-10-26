# CamUp GPU queue (DirectML venv). Success = promoted P*_SVF.csv exists.
# Windows Start-Process often returns ExitCode $null on success; NEVER stop the queue for $null alone.
param(
    [string[]]$Participants = @("P13", "P14", "P15", "P16", "P17")
)

$ErrorActionPreference = "Continue"
$py = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Scripts\python.exe"
$script = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\scripts\SVF Computation\compute_svf_camup.py"
$root = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\SVF Output"
$dml = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Lib\site-packages\tensorflow-plugins\directml"
$plug = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Lib\site-packages\tensorflow-plugins"
$qlog = Join-Path $root "camup_sequential_queue.log"

function Log($m) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $m
    Add-Content -Path $qlog -Value $line
    Write-Host $line
}

function Get-CamUpFinalCsv([string]$Participant, [string]$OutDir) {
    Join-Path $OutDir "${Participant}_SVF.csv"
}

function Test-CamUpPromoted([string]$FinalCsv) {
    (Test-Path $FinalCsv) -and ((Get-Item $FinalCsv).Length -gt 100)
}

while ($true) {
    $live = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -and $_.CommandLine -match "compute_svf_camup" }
    if (-not $live) { break }
    Log "Waiting for compute_svf_camup pid $($live.ProcessId) ..."
    Start-Sleep -Seconds 30
}

Log "Starting participant queue: $($Participants -join ', ')"

foreach ($pidName in $Participants) {
    $outDir = Join-Path $root $pidName
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    $finalCsv = Get-CamUpFinalCsv $pidName $outDir

    if (Test-CamUpPromoted $finalCsv) {
        Log "SKIP $pidName (already promoted: $finalCsv)"
        continue
    }

    $log = Join-Path $outDir "${pidName}_CamUp_GPU_DirectML.log"
    $err = Join-Path $outDir "${pidName}_CamUp_GPU_DirectML.err.log"
    Log "Starting $pidName -> $log"
    $env:PATH = "$dml;$plug;" + $env:PATH
    $env:DML_VISIBLE_DEVICES = "0"
    $env:TF_ENABLE_ONEDNN_OPTS = "0"
    $env:PYTHONNOUSERSITE = "1"
    Remove-Item Env:PYTHONPATH -ErrorAction SilentlyContinue

    $p = Start-Process -FilePath $py `
        -ArgumentList @("-u", "`"$script`"", "--participant", $pidName, "--phase", "all", "--batch-size", "7") `
        -WorkingDirectory "C:\Users\pandya\Documents\Github\docker\Paper3_Final" `
        -RedirectStandardOutput $log -RedirectStandardError $err `
        -PassThru -WindowStyle Hidden
    Log "Launched $pidName launcher pid=$($p.Id)"
    Wait-Process -Id $p.Id

    $code = $p.ExitCode
    $codeText = if ($null -eq $code) { "null" } else { [string]$code }
    Log "Finished $pidName ExitCode=$codeText"

    if (Test-CamUpPromoted $finalCsv) {
        if ($null -ne $code -and [int]$code -ne 0) {
            Log "WARN $pidName ExitCode=$codeText but output OK; queue continues"
        }
        else {
            Log "OK $pidName promoted $finalCsv"
        }
        continue
    }

    Log "STOP queue: $pidName has no promoted CSV at $finalCsv (ExitCode=$codeText). See $log and $err"
    break
}

Log "Queue done"
