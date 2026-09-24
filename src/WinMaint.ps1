[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet("tr-TR", "en-US")]
    [string]$Language = "tr-TR",

    [Parameter()]
    [switch]$DryRun,

    [Parameter()]
    [switch]$SkipDism
)

$modulePath = Join-Path -Path $PSScriptRoot -ChildPath "WinMaint.psm1"
Import-Module -Name $modulePath -Force

Invoke-WinMaintCleanup -Language $Language -DryRun:$DryRun -SkipDism:$SkipDism

