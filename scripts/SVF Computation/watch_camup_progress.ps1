# Watch CamUp SVF Progress lines every N seconds.
# Usage:
#   .\watch_camup_progress.ps1
#   .\watch_camup_progress.ps1 -Participant P10 -IntervalSec 30
#   .\watch_camup_progress.ps1 -LogDir "C:\...\output\SVF Output" -IntervalSec 30

param(
    [string]$Participant = "",
    [string]$LogDir = "C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\SVF Output",
    [int]$IntervalSec = 30
)

$ErrorActionPreference = "Continue"
Write-Host "Watching CamUp logs in: $LogDir  (every ${IntervalSec}s; Ctrl+C to stop)" -ForegroundColor Cyan

while ($true) {
    $stamp = Get-Date -Format "HH:mm:ss"
    # Prefer newest among root CamUp_*.log AND nested *CamUp*.log (e.g. P10\P10_CamUp_GPU_DirectML.log)
    $log = Get-ChildItem -Path $LogDir -Recurse -Filter "*CamUp*.log" -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -notmatch '\.err\.log$' } |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1

    if (-not $log) {
        Write-Host "[$stamp] no CamUp_*.log found" -ForegroundColor Yellow
        Start-Sleep -Seconds $IntervalSec
        continue
    }

    $pattern = if ($Participant) { "Progress\s+$([regex]::Escape($Participant))/" } else { "Progress\s+P\d+/" }
    $line = Select-String -Path $log.FullName -Pattern $pattern -ErrorAction SilentlyContinue |
        Select-Object -Last 1

    $alive = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -and $_.CommandLine -match "compute_svf_camup" } |
        Select-Object -First 1

    $procTag = if ($alive) { "RUNNING pid=$($alive.ProcessId)" } else { "NO PROCESS" }

    if ($line) {
        # Example:
        # Progress P10/WalkU: 231/1691 pending frames attempted | 0.262 frames/s | phase ETA 92.8 min | saved rows 2994 | failures 0
        if ($line.Line -match "Progress\s+(P\d+)/(\w+):\s+(\d+)/(\d+)\s+pending frames attempted\s+\|\s+([\d.]+)\s+frames/s\s+\|\s+phase ETA\s+([\d.]+)\s+min\s+\|\s+saved rows\s+(\d+)\s+\|\s+failures\s+(\d+)") {
            $p = $Matches[1]; $ph = $Matches[2]
            $done = [int]$Matches[3]; $tot = [int]$Matches[4]
            $fps = [double]$Matches[5]; $eta = [double]$Matches[6]
            $rows = [int]$Matches[7]; $fail = [int]$Matches[8]
            $left = $tot - $done
            Write-Host ("[{0}] {1}/{2}: {3}/{4} done | left {5} | {6:N3} fps | ETA {7:N1} min | rows {8} | fail {9} | {10} | log {11}" -f `
                $stamp, $p, $ph, $done, $tot, $left, $fps, $eta, $rows, $fail, $procTag, $log.Name)
        } else {
            Write-Host "[$stamp] $($line.Line.Trim()) | $procTag | $($log.Name)"
        }
    } else {
        Write-Host "[$stamp] no Progress line yet | $procTag | $($log.Name)" -ForegroundColor Yellow
    }

    Start-Sleep -Seconds $IntervalSec
}
