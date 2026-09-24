$scriptDir = $PSScriptRoot
 
. (Join-Path -Path $scriptDir -ChildPath "Core\Privilege.ps1")
. (Join-Path -Path $scriptDir -ChildPath "Core\SystemInfo.ps1")
. (Join-Path -Path $scriptDir -ChildPath "Core\SafeDelete.ps1")
 
function Convert-PSObjectToHashtable {
    # ConvertFrom-Json -AsHashtable yalnizca PowerShell 6.0+ surumlerinde mevcuttur.
    # Windows PowerShell 5.1 uyumlulugu icin PSCustomObject -> Hashtable donusumu elle yapilir.
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [PSObject]$InputObject
    )
 
    process {
        $hash = @{}
        foreach ($property in $InputObject.PSObject.Properties) {
            $hash[$property.Name] = $property.Value
        }
        return $hash
    }
}
 
function Get-WinMaintLanguageMap {
    [CmdletBinding()]
    param(
        [string]$Language = "tr-TR"
    )
 
    $langPath = Join-Path -Path $scriptDir -ChildPath "Data\lang\$Language.json"
    if (-not (Test-Path -Path $langPath)) {
        $langPath = Join-Path -Path $scriptDir -ChildPath "Data\lang\en-US.json"
    }
 
    return (Get-Content -Path $langPath -Raw | ConvertFrom-Json | Convert-PSObjectToHashtable)
}
 
function Invoke-WinMaintCleanup {
    [CmdletBinding()]
    param(
        [string]$Language = "tr-TR",
        [switch]$DryRun,
        [switch]$SkipDism
    )
 
    $lang = Get-WinMaintLanguageMap -Language $Language
    $configPath = Join-Path -Path $scriptDir -ChildPath "Data\config.json"
 
    if (-not (Test-Path -Path $configPath)) {
        Write-Error "Configuration file not found: $configPath"
        return
    }
 
    $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json
 
    if (-not (Assert-AdministratorPrivilege -LanguageMap $lang)) {
        return
    }
 
    $sysInfo = Get-WinMaintSystemInfo
    Write-Host "`n=== $($lang['INFO_STARTING']) ===" -ForegroundColor Cyan
    Write-Host "OS: $($sysInfo.OSName) ($($sysInfo.Architecture)) | Build: $($sysInfo.BuildNumber)" -ForegroundColor Gray
 
    if ($DryRun) {
        Write-Host "$($lang['INFO_DRYRUN'])`n" -ForegroundColor Yellow
    }
 
    $totalFreedMb = 0
 
    foreach ($target in $config.TargetDirectories) {
        $expandedPath = Expand-WinMaintPath -Path $target.Path
        Write-Host ($lang["INFO_CLEANING_PATH"] -f $expandedPath) -ForegroundColor DarkGray
 
        $freed = Remove-SafeItem -TargetPath $target.Path `
                                 -SafeAgeDays $target.SafeAgeDays `
                                 -DryRun:$DryRun `
                                 -LanguageMap $lang
        $totalFreedMb += $freed
    }
 
    if (-not $DryRun) {
        if ($config.SystemServices.FlushDns) {
            if (Get-Command -Name Clear-DnsClientCache -ErrorAction SilentlyContinue) {
                Clear-DnsClientCache -ErrorAction SilentlyContinue
            }
            else {
                # DnsClient modulu bulunmayan sistemler (ornegin Server Core) icin yedek yontem.
                & ipconfig.exe /flushdns | Out-Null
            }
            Write-Host "OK $($lang['INFO_DNS_FLUSH'])" -ForegroundColor Green
        }
 
        if ($config.SystemServices.DismCleanup -and -not $SkipDism) {
            Write-Host "`n$($lang['INFO_DISM_START'])" -ForegroundColor Cyan
            try {
                $dismArgs = "/Online /Cleanup-Image /StartComponentCleanup /ResetBase"
                $process = Start-Process -FilePath "dism.exe" -ArgumentList $dismArgs -NoNewWindow -Wait -PassThru
                if ($process.ExitCode -ne 0) {
                    Write-Warning "DISM exited with code $($process.ExitCode)."
                }
            }
            catch {
                Write-Verbose "DISM cleanup skipped or failed silently."
            }
        }
    }
 
    Write-Host "`n==========================================" -ForegroundColor Green
    Write-Host ($lang["INFO_FREED_SPACE"] -f $totalFreedMb) -ForegroundColor Green
    Write-Host "==========================================`n" -ForegroundColor Green
}
 
Export-ModuleMember -Function Invoke-WinMaintCleanup