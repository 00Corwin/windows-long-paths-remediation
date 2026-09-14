<#
.SYNOPSIS
    Enables Windows long-path support by setting LongPathsEnabled=1.
#>

$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$Name = 'LongPathsEnabled'

try {
    New-ItemProperty `
        -Path $Path `
        -Name $Name `
        -PropertyType DWord `
        -Value 1 `
        -Force `
        -ErrorAction Stop | Out-Null

    $Value = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop

    if ($Value -ne 1) {
        throw "Verification failed. $Name returned '$Value'."
    }

    Write-Output 'Remediated: LongPathsEnabled=1.'
    exit 0
}
catch {
    Write-Output "Remediation failed: $($_.Exception.Message)"
    exit 1
}
