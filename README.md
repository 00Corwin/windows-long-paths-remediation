# Windows Long Paths Remediation

PowerShell scripts for detecting and enabling the Windows
`LongPathsEnabled` registry value.

## Registry setting

`HKLM\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled`

Expected value: `1` (`REG_DWORD`).

## Files

- `Detect-LongPathsEnabled.ps1` is suitable as an Intune Remediation detection
  script.
- `Enable-LongPaths.ps1` is the matching remediation script.
- `Test-AndEnable-LongPaths.ps1` is convenient for a single-device POC or
  SCCM-run script and supports `-WhatIf`.

## Important compatibility note

Enabling the Windows policy does not guarantee that every application supports
paths beyond the traditional Win32 `MAX_PATH` limit. Applications still need
to be long-path aware. Pilot the setting against the relevant business
applications and file workflows.
