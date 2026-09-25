function Get-WinMaintSystemInfo {
    [CmdletBinding()]
    param()

    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $buildNumber = [int]$os.BuildNumber

    # Windows 11 Build 22000 ve üzeridir
    $osName = if ($buildNumber -ge 22000) { "Windows 11" } else { "Windows 10" }

    return [PSCustomObject]@{
        OSName       = $osName
        Version      = $os.Version
        BuildNumber  = $buildNumber
        Architecture = $os.OSArchitecture
    }
}

function Expand-WinMaintPath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    return [Environment]::ExpandEnvironmentVariables($Path)
}

