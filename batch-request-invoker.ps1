# Batch Request Invoker PowerShell Script

# Configuration Variables
$ENABLE_URL_FILE = $false  # Set to $false to disable URL file feature
$DEFAULT_URL = "https://your-api.com/health"

# Header ASCII Art
Clear-Host
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                                                                              ║" -ForegroundColor Cyan
Write-Host "║  ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ███████╗██╗  ██╗███████╗██╗     ██╗              ║" -ForegroundColor Cyan
Write-Host "║  ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║              ║" -ForegroundColor Cyan
Write-Host "║  ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝███████╗███████║█████╗  ██║     ██║              ║" -ForegroundColor Cyan
Write-Host "║  ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗╚════██║██╔══██║██╔══╝  ██║     ██║              ║" -ForegroundColor Cyan
Write-Host "║  ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║███████║██║  ██║███████╗███████╗███████╗         ║" -ForegroundColor Cyan
Write-Host "║  ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝         ║" -ForegroundColor Cyan
Write-Host "║                                                                                              ║" -ForegroundColor Cyan
Write-Host "║                     BATCH REQUEST INVOKER V2.3.9 BY @Ash1421                                 ║" -ForegroundColor Cyan
Write-Host "║                                                                                              ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Configuration Section
Write-Host "┌─────────────────────────────────────────┐" -ForegroundColor Magenta
Write-Host "│         CONFIGURATION SETUP             │" -ForegroundColor Magenta
Write-Host "└─────────────────────────────────────────┘" -ForegroundColor Magenta
Write-Host ""

$totalRequests = [int](Read-Host "  → Total number of requests")
$maxParallel   = [int](Read-Host "  → Max parallel requests   ")

$urls = @()

if ($ENABLE_URL_FILE) {
    $useUrlFile = Read-Host "  → Use urlfile.txt? (y/n)   "
    
    if ($useUrlFile -eq "y" -or $useUrlFile -eq "Y") {
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
        $urlFilePath = Join-Path $scriptDir "urlfile.txt"
        
        if (Test-Path $urlFilePath) {
            $urls = Get-Content $urlFilePath | Where-Object { $_.Trim() -ne "" }
            Write-Host "  ✓ Loaded $($urls.Count) URLs from urlfile.txt" -ForegroundColor Blue
            if ($urls.Count -eq 0) {
                Write-Host "  ⚠ File is empty, using default URL" -ForegroundColor Yellow
                $urls = @($DEFAULT_URL)
            }
        } else {
            Write-Host "  ⚠ urlfile.txt not found, using default URL" -ForegroundColor Yellow
            $urls = @($DEFAULT_URL)
        }
    } else {
        $url = Read-Host "  → URL (Enter for default)  "
        if ([string]::IsNullOrEmpty($url)) {
            Write-Host "  ✓ Using default URL" -ForegroundColor DarkGray
            $urls = @($DEFAULT_URL)
        } else {
            $urls = @($url)
        }
    }
} else {
    $url = Read-Host "  → URL (Enter for default)  "
    if ([string]::IsNullOrEmpty($url)) {
        Write-Host "  ✓ Using default URL" -ForegroundColor DarkGray
        $urls = @($DEFAULT_URL)
    } else {
        $urls = @($url)
    }
}

Write-Host ""
Write-Host "┌─────────────────────────────────────────┐" -ForegroundColor DarkMagenta
Write-Host "│         EXECUTION STARTED               │" -ForegroundColor DarkMagenta
Write-Host "└─────────────────────────────────────────┘" -ForegroundColor DarkMagenta
Write-Host ""

$Completed = 0
$Failed = 0
$ActiveJobs = @()
$BarLength = 40
$StartTime = Get-Date

function Update-ProgressBar {
    $percent = if ($totalRequests -eq 0) { 0 } else { [math]::Round(($Completed / $totalRequests) * 100) }
    $filled = [math]::Round(($percent / 100) * $BarLength)
    $empty = $BarLength - $filled
    
    # Create gradient bar with different characters
    $bar = "["
    for ($i = 0; $i -lt $filled; $i++) {
        if (($i -eq ($filled - 1)) -and ($filled -lt $BarLength)) {
            $bar += ">"
        } else {
            $bar += "█"
        }
    }
    $bar += "░" * $empty
    $bar += "]"
    
    # Calculate elapsed time and rate
    $elapsed = (Get-Date) - $StartTime
    $rate = if ($elapsed.TotalSeconds -gt 0) { [math]::Round($Completed / $elapsed.TotalSeconds, 2) } else { 0 }
    
    # Color coding based on status - Purple gradient
    $barColor = if ($percent -lt 33) { "DarkMagenta" } elseif ($percent -lt 66) { "Magenta" } else { "Blue" }
    
    Write-Host -NoNewline "`r"
    Write-Host -NoNewline "  " -ForegroundColor DarkGray
    Write-Host -NoNewline $bar -ForegroundColor $barColor
    Write-Host -NoNewline " $percent% " -ForegroundColor White
    Write-Host -NoNewline "│ " -ForegroundColor DarkGray
    Write-Host -NoNewline "✓ " -ForegroundColor Green
    Write-Host -NoNewline "$Completed" -ForegroundColor Green
    Write-Host -NoNewline " / " -ForegroundColor DarkGray
    Write-Host -NoNewline "$totalRequests" -ForegroundColor White
    Write-Host -NoNewline " │ " -ForegroundColor DarkGray
    Write-Host -NoNewline "⚡ " -ForegroundColor Yellow
    Write-Host -NoNewline "$($ActiveJobs.Count)" -ForegroundColor Yellow
    Write-Host -NoNewline " active │ " -ForegroundColor DarkGray
    Write-Host -NoNewline "⚠ " -ForegroundColor Red
    Write-Host -NoNewline "$Failed" -ForegroundColor Red
    Write-Host -NoNewline " failed │ " -ForegroundColor DarkGray
    Write-Host -NoNewline "⏱ " -ForegroundColor Cyan
    Write-Host -NoNewline "$rate req/s" -ForegroundColor Cyan
}

# Main execution loop
for ($i = 1; $i -le $totalRequests; $i++) {
    while ($ActiveJobs.Count -ge $maxParallel) {
        foreach ($job in $ActiveJobs) {
            if ($job.State -eq "Completed" -or $job.State -eq "Failed" -or $job.State -eq "Stopped") {
                $result = Receive-Job $job
                if ($job.State -eq "Failed" -or $result -eq "Failed") {
                    $Failed++
                }
                Remove-Job $job
                $ActiveJobs = $ActiveJobs | Where-Object { $_.Id -ne $job.Id }
                $Completed++
                Update-ProgressBar
            }
        }
        Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 300)
    }

    # Select URL from list (cycle through if multiple)
    $currentUrl = $urls[($i - 1) % $urls.Count]

    $job = Start-Job -ScriptBlock {
        param($url)
        try {
            Invoke-WebRequest -Uri $url -UseBasicParsing | Out-Null
            return "Success"
        } catch {
            return "Failed"
        }
    } -ArgumentList $currentUrl

    if ($ActiveJobs -isnot [System.Collections.ArrayList]) {
        $ActiveJobs = @($ActiveJobs)
    }
    $ActiveJobs += $job
    Update-ProgressBar
}

# Wait for remaining jobs
while ($ActiveJobs.Count -gt 0) {
    foreach ($job in $ActiveJobs) {
        if ($job.State -eq "Completed" -or $job.State -eq "Failed" -or $job.State -eq "Stopped") {
            $result = Receive-Job $job
            if ($job.State -eq "Failed" -or $result -eq "Failed") {
                $Failed++
            }
            Remove-Job $job
            $ActiveJobs = $ActiveJobs | Where-Object { $_.Id -ne $job.Id }
            $Completed++
            Update-ProgressBar
        }
    }
    Start-Sleep -Milliseconds (Get-Random -Minimum 50 -Maximum 300)
}

# Final summary
$EndTime = Get-Date
$TotalTime = $EndTime - $StartTime

Write-Host "`n"
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║                   EXECUTION COMPLETE                      ║" -ForegroundColor Magenta
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""
Write-Host "  ✓ Total Requests:    " -NoNewline -ForegroundColor White
Write-Host "$totalRequests" -ForegroundColor Magenta
Write-Host "  ✓ Successful:        " -NoNewline -ForegroundColor White
Write-Host "$($totalRequests - $Failed)" -ForegroundColor Blue
Write-Host "  ⚠ Failed:            " -NoNewline -ForegroundColor White
Write-Host "$Failed" -ForegroundColor $(if ($Failed -gt 0) { "Red" } else { "Blue" })
Write-Host "  ⏱ Total Time:        " -NoNewline -ForegroundColor White
Write-Host "$([math]::Round($TotalTime.TotalSeconds, 2)) seconds" -ForegroundColor DarkMagenta
Write-Host "  ⚡ Average Rate:      " -NoNewline -ForegroundColor White
Write-Host "$([math]::Round($totalRequests / $TotalTime.TotalSeconds, 2)) req/s" -ForegroundColor Magenta
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor DarkGray
Write-Host ""