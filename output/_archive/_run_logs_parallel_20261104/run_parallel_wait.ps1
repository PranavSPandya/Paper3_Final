$ErrorActionPreference = 'Stop'
$root = 'C:\Users\sanga\Desktop\Pranav Paper3_Final'
Set-Location $root
$logDir = Join-Path $root 'output\statistical_analysis\_run_logs_parallel_20261104'
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

$subfolderMap = @{
  'H5_combined_phaseavg.R' = 'H5_combined_phaseavg'
  'H5_combined_timeseries.R' = 'H5_combined_timeseries'
  'H1_H3_phaseavg.R' = 'H1_H3_phaseavg'
  'H1_H3_timeseries.R' = 'H1_H3_timeseries'
  'H4_sound_literature_test.R' = 'H4_sound_literature_test'
  'randomness_phaseavg.R' = 'randomness_phaseavg'
  'Merge_statistical_outputs.R' = 'output/merged (not under results/)'
}

function Start-RScriptJob {
  param([string]$ScriptName)
  $base = [IO.Path]::GetFileNameWithoutExtension($ScriptName)
  $log = Join-Path $logDir "$base.log"
  if (Test-Path $log) { Remove-Item $log -Force }
  $rel = "scripts\statistical_analysis\$ScriptName"
  $cmdLine = "Rscript.exe `"$rel`" > `"$log`" 2>&1"
  $p = Start-Process -FilePath 'cmd.exe' -ArgumentList '/c', $cmdLine -WorkingDirectory $root -PassThru -WindowStyle Hidden
  [PSCustomObject]@{ Script = $ScriptName; Parallel = $true; ProcessId = $p.Id; Process = $p; Start = Get-Date; Log = $log }
}

function Wait-RJobs {
  param($Jobs)
  foreach ($j in $Jobs) {
    $null = $j.Process.WaitForExit()
    $tail = ''
    if (Test-Path $j.Log) {
      $lines = Get-Content $j.Log -ErrorAction SilentlyContinue
      if ($lines) { $tail = ($lines | Select-Object -Last 8) -join ' | ' }
      if ($tail.Length -gt 400) { $tail = $tail.Substring($tail.Length - 400) }
    }
    $sec = [math]::Round(((Get-Date) - $j.Start).TotalSeconds, 1)
    [PSCustomObject]@{
      Script = $j.Script
      Parallel = $j.Parallel
      Exit = $j.Process.ExitCode
      Seconds = $sec
      ResultsSubfolder = $subfolderMap[$j.Script]
      ErrorSnippet = if ($j.Process.ExitCode -ne 0) { $tail } else { '' }
    }
  }
}

# Kill prior stuck launches (same six scripts only)
$targets = $subfolderMap.Keys | Where-Object { $_ -ne 'Merge_statistical_outputs.R' }
Get-CimInstance Win32_Process -Filter "Name = 'Rscript.exe'" -ErrorAction SilentlyContinue | ForEach-Object {
  $cmd = $_.CommandLine
  foreach ($t in $targets) {
    if ($cmd -like "*$t*") {
      Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
    }
  }
}
Start-Sleep -Seconds 2

$parallelScripts = @(
  'H5_combined_phaseavg.R',
  'H5_combined_timeseries.R',
  'H1_H3_phaseavg.R',
  'H1_H3_timeseries.R',
  'H4_sound_literature_test.R',
  'randomness_phaseavg.R'
)

$jobs = foreach ($s in $parallelScripts) { Start-RScriptJob -ScriptName $s }
$results = @(Wait-RJobs -Jobs $jobs)

# Merge after parallel batch (reads results/)
$mergeJob = Start-RScriptJob -ScriptName 'Merge_statistical_outputs.R'
$mergeJob.Parallel = $false
$results += Wait-RJobs -Jobs @($mergeJob)

$results | Export-Csv (Join-Path $logDir 'summary.csv') -NoTypeInformation
$results | Format-Table -AutoSize | Out-String | Write-Output
