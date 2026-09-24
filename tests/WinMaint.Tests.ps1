Describe "WinMaint Language Configuration Tests" {
    It "tr-TR dil dosyasi gecerli bir JSON olmali" {
        Get-Content -Path "src/Data/lang/tr-TR.json" -Raw | ConvertFrom-Json | Should -Not -BeNullOrEmpty
    }

    It "en-US dil dosyasi gecerli bir JSON olmali" {
        Get-Content -Path "src/Data/lang/en-US.json" -Raw | ConvertFrom-Json | Should -Not -BeNullOrEmpty
    }
}

Describe "WinMaint Config Tests" {
    It "config.json dosyasi gecerli bir yapida olmali" {
        $config = Get-Content -Path "src/Data/config.json" -Raw | ConvertFrom-Json
        $config.TargetDirectories | Should -Not -BeNullOrEmpty
    }
}
