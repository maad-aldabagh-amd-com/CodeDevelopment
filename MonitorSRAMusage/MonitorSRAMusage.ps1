# MonitorSRAMusage.ps2

param (
    [string]$processName
)

if (-not $processName) {
    Write-Output "Please provide a process name."
    exit
}

# Function to get SRAM usage of the process
function Get-SRAMUsage {
    param (
        [string]$processName
    )

    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        $sramUsage = $process.PrivateMemorySize64 / 1MB
        Write-Output "Process: $processName, SRAM Usage: $sramUsage MB"
    } else {
        Write-Output "Process $processName not found."
    }
}

# Monitor the SRAM usage every 5 seconds
while ($true) {
    Get-SRAMUsage -processName $processName
    Start-Sleep -Seconds 5
}