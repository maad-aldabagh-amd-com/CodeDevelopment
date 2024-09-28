# Define the process name you want to monitor
$processName = "YourProcessName"

# Function to get SRAM usage of the process
function Get-SramUsage {
    param (
        [string]$processName
    )

    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($process) {
        $sramUsage = $process.PrivateMemorySize64 / 1MB
        return $sramUsage
    } else {
        Write-Output "Process $processName not found."
        return $null
    }
}

# Monitor SRAM usage in a loop
while ($true) {
    $sramUsage = Get-SramUsage -processName $processName
    if ($sramUsage -ne $null) {
        Write-Output "SRAM Usage for $processName: $sramUsage MB"
    }
    Start-Sleep -Seconds 5
}