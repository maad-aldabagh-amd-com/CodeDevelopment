# Define the process name you want to monitor
# Read CLI input and assign to processName
param (
    [string]$processName
)

if (-not $processName) {
    Write-Host "Please provide a process name."
    exit
}

# Function to get SRAM usage of the process
function Get-SramUsage {
    param (
        [string]$processName
    )

    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($null -eq $process) {
        Write-Output "Process '$processName' not found."
    } else {
        # Calculate SRAM usage in MB
        $sramUsage = $process.PrivateMemorySize64 / 1MB
        Write-Output "SRAM Usage: $sramUsage MB"
        return $sramUsage
    }
}

# Monitor SRAM usage in a loop
while ($true) {
    $sramUsage = Get-SramUsage -processName $processName
    if ($sramUsage -ne $null) {
        Write-Output "SRAM Usage for ${processName}: $sramUsage MB"
    }
    Start-Sleep -Seconds 5
}
// End of script