# Get the list of processes
$processes = Get-Process | Select-Object Name, Id

# Output the process names and IDs in column format
$processes | ForEach-Object {
    "{0,-30} {1,10}" -f $_.Name, $_.Id
}