$rscript = "C:\Program Files\R\R-4.6.1\bin\Rscript.exe"
$root = "C:\Users\sanga\Desktop\Pranav Paper3_Final"
$logdir = Join-Path $root "output\statistical_analysis\results_casestudy\logs"
function Wait-Free([int]$minutes) {
  $deadline = (Get-Date).AddMinutes($minutes)
  do {
    $rs = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq "Rscript.exe" -and $_.CommandLine -like "*statistical_analysis_casestudy*" })
    if ($rs.Count -eq 0) { return $true }
    Start-Sleep -Seconds 30
  } while ((Get-Date) -lt $deadline)
  return $false
}
function Run-Job($cov, $name, $threads, $minutes) {
  if (-not (Wait-Free 5)) { Write-Output "BLOCKED $cov $name"; return $false }
  $log = Join-Path $logdir ($cov + "_" + $name + ".log")
  $script = Join-Path $root ("scripts\statistical_analysis_casestudy\" + $name + ".R")
  $env:PAPER3_CASESTUDY_COVARIATE = $cov
  if ($threads) { $env:OPENBLAS_NUM_THREADS = "1"; $env:OMP_NUM_THREADS = "1" }
  $p = Start-Process -FilePath $rscript -ArgumentList @($script) -WorkingDirectory $root -RedirectStandardOutput $log -RedirectStandardError ($log + ".err") -WindowStyle Hidden -PassThru
  Write-Output ("START " + $cov + " " + $name + " pid=" + $p.Id)
  if (-not $p.WaitForExit($minutes * 60000)) { Write-Output ("TIMEOUT " + $name); return $false }
  $halt = Select-String -Path $log, ($log + ".err") -Pattern "Execution halted" -SimpleMatch -ErrorAction SilentlyContinue
  Write-Output ("END " + $cov + " " + $name + " exit=" + $p.ExitCode + " halted=" + [bool]$halt)
  return ($p.ExitCode -eq 0 -and -not $halt)
}
Write-Output "WAIT_ACTIVENESS"
if (-not (Wait-Free 60)) { Write-Output "ACTIVENESS_STILL_RUNNING"; exit 1 }
$ok = Run-Job "fitness" "H5_hotspot_weather" $true 45
$day = Join-Path $root "output\statistical_analysis\results_casestudy\fitness\H5_exploratory\H5_hotspot_day.csv"
Write-Output ("fitness_day=" + (Test-Path $day))
if (-not $ok -or -not (Test-Path $day)) { exit 2 }
Run-Job "fitness" "H5_hotspot_weather_svfclasses" $true 30 | Out-Null
$ok2 = Run-Job "activeness" "H5_hotspot_weather" $true 45
$day2 = Join-Path $root "output\statistical_analysis\results_casestudy\activeness\H5_exploratory\H5_hotspot_day.csv"
Write-Output ("activeness_day=" + (Test-Path $day2))
if (-not $ok2 -or -not (Test-Path $day2)) { exit 3 }
Run-Job "activeness" "H5_hotspot_weather_svfclasses" $true 30 | Out-Null
Write-Output "REMAINING_DONE"
