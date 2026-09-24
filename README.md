WinMaint 
Windows'ta zamanla biriken temp dosyaları, DNS artıkları ve DISM şişkinlikleriyle uğraşmaktan sıkılıp yazdığım modüler bir bakım ve temizlik betiği.

Sistemdeki kritik dosyaları ve yakın tarihte açılmış geçici verileri (varsayılan 7 gün) patlatmadan, güvenli bir şekilde alan açmayı hedefliyor.

 Neden Yapıldı?
Windows'un kendi disk temizleme aracı veya piyasadaki 3. parti temizleyiciler ya neyi sildiğini tam söylemiyor ya da sistemi bozacak kadar agresif çalışabiliyor. WinMaint ile:

Nelerin silineceğini esnek bir JSON konfigürasyonundan yönetebiliyorsunuz.

Sadece belirlenen günden eski dosyalar siliniyor (SafeAgeDays).

Tek bir parametreyle önce simülasyon çalıştırıp ne kadar yer açılacağını görebiliyorsunuz.

 Hızlı Başlangıç
PowerShell Üzerinden
PowerShell
# Repoyu klonlayın
git clone [https://github.com/furkanmutaf/WinMaint.git](https://github.com/furkanmutaf/WinMaint.git)
cd WinMaint

# Betik çalıştırma izni hatası alırsanız (İsteğe bağlı):
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

# Simülasyon modunda test edin (Hiçbir şey silinmez)
.\src\WinMaint.ps1 -DryRun -Language tr-TR

# Gerçek temizliği başlatın (Yönetici Hakları Gerektirir)
.\src\WinMaint.ps1 -Language tr-TR
CMD (Komut İstemi) Üzerinden
DOS
powershell -ExecutionPolicy Bypass -File ".\src\WinMaint.ps1" -Language tr-TR
Not: DISM bileşen deposu temizliği biraz zaman alabilir. İstemiyorsanız -SkipDism parametresini ekleyebilirsiniz.

 Kendinize Göre Özelleştirin
Temizlenecek yolları ve "kaç günlük dosyalar güvenli" kuralını src/Data/config.json dosyasından kolayca değiştirebilirsiniz:

JSON
{
  "TargetDirectories": [
    {
      "Path": "%TEMP%",
      "SafeAgeDays": 7
    },
    {
      "Path": "%SYSTEMROOT%\\Temp",
      "SafeAgeDays": 7
    }
  ],
  "SystemServices": {
    "FlushDns": true,
    "DismCleanup": true
  }
}
 Testler
Projeyi kendi ortamınızda geliştirecekseniz Pester testlerini koşturabilirsiniz:

PowerShell
Invoke-Pester -Path .\tests\WinMaint.Tests.ps1
 Lisans
MIT - İstediğiniz gibi kullanın, forklayın, geliştirin.
