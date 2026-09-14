<#
.SYNOPSIS
    Checks and enables Windows long-path support in one run.

.DESCRIPTION
    Useful for a single-device proof of concept or an SCCM script.
#>

[CmdletBinding(SupportsShouldProcess)]
param()

$Path = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$Name = 'LongPathsEnabled'

try {
    $Current = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction SilentlyContinue

    if ($Current -eq 1) {
        Write-Output 'No change required: LongPathsEnabled=1.'
        exit 0
    }

    if ($PSCmdlet.ShouldProcess("$Path\$Name", 'Set DWORD value to 1')) {
        New-ItemProperty -Path $Path -Name $Name -PropertyType DWord -Value 1 -Force -ErrorAction Stop | Out-Null
    }

    $Verified = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop

    if ($Verified -eq 1) {
        Write-Output 'Long path support is enabled.'
        exit 0
    }

    throw "Verification failed. Current value: $Verified"
}
catch {
    Write-Output "Failed: $($_.Exception.Message)"
    exit 1
}
