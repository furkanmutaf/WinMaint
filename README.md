# WinMaint 

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B%20%7C%207%2B-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-Windows%2010%20%7C%2011-lightgrey)

Windows'ta zamanla biriken temp dosyaları, DNS artıkları ve DISM şişkinlikleriyle uğraşmaktan sıkılıp yazdığım modüler bir bakım ve temizlik betiği. 

Sistemdeki kritik dosyaları ve yakın tarihte açılmış geçici verileri (varsayılan 7 gün) patlatmadan, güvenli bir şekilde alan açmayı hedefliyor.

---

##  Neden Yapıldı?

Windows'un kendi disk temizleme aracı veya piyasadaki 3. parti temizleyiciler ya neyi sildiğini tam söylemiyor ya da sistemi bozacak kadar agresif çalışabiliyor. **WinMaint** ile:
- Nelerin silineceğini esnek bir JSON konfigürasyonundan yönetebiliyorsunuz.
- Sadece belirlenen günden eski dosyalar siliniyor (`SafeAgeDays`).
- Tek bir parametreyle önce simülasyon çalıştırıp ne kadar yer açılacağını görebiliyorsunuz.

---

##  Hızlı Başlangıç

### PowerShell Üzerinden

\`\`\`powershell
# Repoyu klonlayın
git clone https://github.com/kullaniciadi/WinMaint.git
cd WinMaint

# Betik çalıştırma izni hatası alırsanız (İsteğe bağlı):
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

# Simülasyon modunda test edin (Hiçbir şey silinmez)
.\src\WinMaint.ps1 -DryRun -Language tr-TR

# Gerçek temizliği başlatın (Yönetici Hakları Gerektirir)
.\src\WinMaint.ps1 -Language tr-TR
\`\`\`

### CMD (Komut İstemi) Üzerinden

\`\`\`cmd
powershell -ExecutionPolicy Bypass -File ".\src\WinMaint.ps1" -Language tr-TR
\`\`\`

> **Not:** DISM bileşen deposu temizliği biraz zaman alabilir. İstemiyorsanız `-SkipDism` parametresini ekleyebilirsiniz.

---

##  Kendinize Göre Özelleştirin

Temizlenecek yolları ve "kaç günlük dosyalar güvenli" kuralını `src/Data/config.json` dosyasından kolayca değiştirebilirsiniz:

\`\`\`json
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
\`\`\`

---

##  Testler

Projeyi kendi ortamınızda geliştirecekseniz Pester testlerini koşturabilirsiniz:

\`\`\`powershell
Invoke-Pester -Path .\tests\WinMaint.Tests.ps1
\`\`\`

---

##  Lisans

[MIT](LICENSE) - İstediğiniz gibi kullanın, forklayın, geliştirin.