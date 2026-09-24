# WinMaint

WinMaint, Windows'ta zamanla biriken geçici dosyaları, DNS önbellek artıklarını ve DISM bileşen deposu şişkinliğini temizlemek için yazdığım modüler bir PowerShell betiği.

Windows'un kendi disk temizleme aracı ile piyasadaki üçüncü parti temizleyicilerin ortak sorunu, neyi sildiklerini net şekilde göstermemeleri ya da sistemi bozacak kadar agresif davranabilmeleri. WinMaint bu ikisinin ortasında bir yer tutmayı hedefliyor: ne silineceği baştan belli, hangi dosyaların güvenli sayılacağı yaş sınırıyla kontrol ediliyor ve gerçek silme işleminden önce simülasyon modu ile önizleme yapılabiliyor.

## Özellikler

- Temizlenecek dizinler ve kurallar `config.json` üzerinden yönetiliyor, betiğe dokunmadan özelleştirilebiliyor.
- Her hedef dizin için ayrı bir güvenli yaş sınırı (`SafeAgeDays`) tanımlanabiliyor; varsayılan olarak 7 günden yeni dosyalara dokunulmuyor.
- `-DryRun` parametresiyle hiçbir dosya silinmeden, ne kadar alan açılacağı önceden görülebiliyor.
- DNS önbelleği temizliği ve DISM bileşen deposu bakımı ayrı ayrı açılıp kapatılabiliyor.
- Türkçe ve İngilizce dil desteği mevcut.

## Kurulum ve Kullanım

Repoyu klonlayın:

```powershell
git clone https://github.com/furkanmutaf/WinMaint.git
cd WinMaint
```

Betik çalıştırma izniyle ilgili bir hata alırsanız:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
```

Önce simülasyon modunda çalıştırıp neyin silineceğini görün:

```powershell
.\src\WinMaint.ps1 -DryRun -Language tr-TR
```

Sorun yoksa gerçek temizliği başlatın (yönetici hakları gerektirir):

```powershell
.\src\WinMaint.ps1 -Language tr-TR
```

Komut isteminden çalıştırmak isterseniz:

```dos
powershell -ExecutionPolicy Bypass -File ".\src\WinMaint.ps1" -Language tr-TR
```

DISM bileşen deposu temizliği biraz zaman alabilir; atlamak isterseniz `-SkipDism` parametresini ekleyin.

## Yapılandırma

Temizlenecek yollar ve güvenli yaş sınırı `src/Data/config.json` dosyasından düzenlenir:

```json
{
  "TargetDirectories": [
    { "Path": "%TEMP%", "SafeAgeDays": 7 },
    { "Path": "%SYSTEMROOT%\\Temp", "SafeAgeDays": 7 }
  ],
  "SystemServices": {
    "FlushDns": true,
    "DismCleanup": true
  }
}
```

Yeni bir dizin eklemek ya da yaş sınırını değiştirmek için betik kodunu değiştirmenize gerek yok, yalnızca bu dosyayı düzenlemeniz yeterli.

## Testler

```powershell
Invoke-Pester -Path .\tests\WinMaint.Tests.ps1
```

## Lisans

MIT lisansı ile yayınlanmıştır. Dilediğiniz gibi kullanabilir, fork'layabilir ve geliştirebilirsiniz.
