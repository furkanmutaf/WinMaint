function Test-IsAdministrator {
    [CmdletBinding()]
    param()

    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Assert-AdministratorPrivilege {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]$LanguageMap
    )

    if (-not (Test-IsAdministrator)) {
        Write-Error $LanguageMap["ERR_ADMIN_REQUIRED"]
        return $false
    }
    return $true
}

