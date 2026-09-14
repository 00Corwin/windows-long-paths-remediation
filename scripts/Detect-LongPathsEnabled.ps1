<#
.SYNOPSIS
    Intune detection script for Windows long-path support.
#>

$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$Name = 'LongPathsEnabled'

try {
    $Value = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop

    if ($Value -eq 1) {
        Write-Output 'Compliant: LongPathsEnabled=1.'
        exit 0
    }

    Write-Output "Non-compliant: LongPathsEnabled=$Value."
    exit 1
}
catch {
    Write-Output "Non-compliant: $Name is missing or unreadable. $($_.Exception.Message)"
    exit 1
}
