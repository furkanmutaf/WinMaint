function Remove-SafeItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$TargetPath,

        [Parameter()]
        [int]$SafeAgeDays = 1,

        [Parameter()]
        [switch]$DryRun,

        [Parameter()]
        [hashtable]$LanguageMap
    )

    $resolvedPath = Expand-WinMaintPath -Path $TargetPath

    if (-not (Test-Path -Path $resolvedPath)) {
        return 0
    }

    $freedBytes = 0
    $cutoffDate = (Get-Date).AddDays(-$SafeAgeDays)

    # Dizin içeriğini güvenle al
    $items = Get-ChildItem -Path $resolvedPath -Recurse -Force -ErrorAction SilentlyContinue

    foreach ($item in $items) {
        # Dizini değil, sadece dosyaları hedefle
        if ($item.PSIsContainer) { continue }

        try {
            # Belirtilen günden daha eski dosyaları temizle
            if ($item.LastWriteTime -lt $cutoffDate) {
                $fileSize = $item.Length

                if (-not $DryRun) {
                    Remove-Item -Path $item.FullName -Force -ErrorAction Stop
                }

                $freedBytes += $fileSize
            }
        }
        catch {
            # Kilitli dosyalarda veya erişim engellerinde betiğin durmasını engelle
            if ($LanguageMap -and $LanguageMap.ContainsKey("WARN_LOCKED_FILE")) {
                Write-Verbose ($LanguageMap["WARN_LOCKED_FILE"] -f $item.FullName)
            }
        }
    }

    return [math]::Round($freedBytes / 1MB, 2)
}

