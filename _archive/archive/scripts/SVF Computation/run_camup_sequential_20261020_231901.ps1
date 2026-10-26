# Sequential CamUp SVF — same as P10: Anaconda python, batch-size 7, NVIDIA GPU.
param(
    [string[]]$Participants = @("P11", "P12", "P13", "P14", "P15", "P16", "P17"),
    [int]$BatchSize = 7,
    [string]$Python = "C:\ProgramData\Anaconda3\python.exe"
)

$ErrorActionPreference = "Continue"
$ScriptDir = $PSScriptRoot
$LogRoot = Join-Path $ScriptDir "..\..\output\SVF Output"
New-Item -ItemType Directory -Force -Path $LogRoot | Out-Null
$LogRoot = (Resolve-Path $LogRoot).Path
$MasterLog = Join-Path $LogRoot "camup_sequential_queue.log"

function Write-Log([string]$Message) {
    $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Message
    Add-Content -Path $MasterLog -Value $line
    Write-Host $line
}

$env:CUDA_VISIBLE_DEVICES = "0"
$env:TF_CPP_MIN_LOG_LEVEL = "3"
$env:TF_ENABLE_ONEDNN_OPTS = "0"
$env:TF_USE_LEGACY_KERAS = "1"
$env:PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION = "python"

Write-Log "Queue: $($Participants -join ', ') | batch-size=$BatchSize"

foreach ($participant in $Participants) {
    while ($true) {
        $running = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
            Where-Object { $_.CommandLine -and $_.CommandLine -match "compute_svf_camup\.py" }
        if (-not $running) { break }
        Write-Log "Waiting for pid $($running.ProcessId) before $participant ..."
        Start-Sleep -Seconds 30
    }

    $outDir = Join-Path $LogRoot $participant
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    $runLog = Join-Path $outDir "${participant}_CamUp_GPU_DirectML.log"
    $errLog = Join-Path $outDir "${participant}_CamUp_GPU_DirectML.err.log"
    $camup = Join-Path $ScriptDir "compute_svf_camup.py"

    $finalCsv = Join-Path $outDir "${participant}_SVF.csv"
    if ((Test-Path $finalCsv) -and ((Get-Item $finalCsv).Length -gt 100)) {
        Write-Log "SKIP $participant (already promoted: $finalCsv)"
        continue
    }

    Write-Log "Starting $participant -> $runLog"
    $proc = Start-Process -FilePath $Python -WorkingDirectory $ScriptDir -PassThru -NoNewWindow `
        -ArgumentList @($camup, "--participant", $participant, "--phase", "all", "--batch-size", "$BatchSize") `
        -RedirectStandardOutput $runLog -RedirectStandardError $errLog
    Write-Log "Launched $participant pid=$($proc.Id)"
    Wait-Process -Id $proc.Id
    $code = $proc.ExitCode
    $codeText = if ($null -eq $code) { "null" } else { [string]$code }
    Write-Log "Finished $participant ExitCode=$codeText"

    if ((Test-Path $finalCsv) -and ((Get-Item $finalCsv).Length -gt 100)) {
        if ($null -ne $code -and [int]$code -ne 0) {
            Write-Log "WARN $participant ExitCode=$codeText but output OK; queue continues"
        }
        continue
    }
    if ($null -ne $code -and [int]$code -ne 0) {
        Write-Log "STOP queue: $participant exit $codeText and no $finalCsv; see $errLog"
        exit [int]$code
    }
    Write-Log "STOP queue: $participant missing $finalCsv (ExitCode=$codeText); see $errLog"
    exit 1
}

Write-Log "Queue complete."
