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

# Windows PowerShell 5.1'de konsol varsayilan olarak OEM kod sayfasi kullanir;
# bu satir Turkce/UTF-8 karakterlerin dogru gorunmesini garanti eder (PS 7'de zaten varsayilan).
try {
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.Encoding]::UTF8
}
catch {
    Write-Verbose "Console encoding degistirilemedi, varsayilan kullanilacak."
}

$modulePath = Join-Path -Path $PSScriptRoot -ChildPath "WinMaint.psm1"
Import-Module -Name $modulePath -Force

Invoke-WinMaintCleanup -Language $Language -DryRun:$DryRun -SkipDism:$SkipDism
