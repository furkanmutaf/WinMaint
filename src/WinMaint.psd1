#
# 'WinMaint' modülü için modül bildirimi
#
# Oluşturan: Adem Furkan Mutaf
#
# 23.09.2026 tarihinde oluşturuldu
#

@{

# Bu bildirimle ilişkilendirilmiş betik modülü veya ikili modül dosyası.
RootModule = 'WinMaint.psm1'

# Bu modülün sürüm numarası.
ModuleVersion = '1.0.0'

# Desteklenen PSEdition'lar
# CompatiblePSEditions = @()

# Bu modülü benzersiz olarak tanımlamak için kullanılan kimlik
GUID = 'a96340b0-74b7-4812-af6c-b9c9efbcf3b2'

# Bu modülün yazarı
Author = 'Adem Furkan Mutaf'

# Bu modülün şirketi veya satıcısı
CompanyName = 'OpenSource'

# Bu modül için telif hakkı bildirimi
Copyright = '(c) Adem Furkan Mutaf. Tüm hakları saklıdır.'

# Bu modülün sağladığı işlevselliğin açıklaması
Description = 'Windows bakım, geçici dosya temizliği ve sistem optimizasyon otomasyonu.'

# Bu modülün gerektirdiği PowerShell altyapısının en düşük sürümü
PowerShellVersion = '5.1'

# Bu modül için gerekli PowerShell konağının adı
# PowerShellHostName = ''

# Bu modülün gerektirdiği PowerShell konağının en düşük sürümü
# PowerShellHostVersion = ''

# Bu modül için gereken en düşük Microsoft .NET Framework sürümü. Bu önkoşul yalnızca PowerShell Desktop sürümü için geçerlidir.
# DotNetFrameworkVersion = ''

# Bu modülün gerektirdiği en düşük ortak dil çalışma zamanı (CLR) sürümü. Bu önkoşul yalnızca PowerShell Desktop sürümü için geçerlidir.
# ClrVersion = ''

# Bu modülün gerektirdiği işlemci mimarisi (None, X86, Amd64)
# ProcessorArchitecture = ''

# Bu modül içeri aktarılmadan önce genel ortama aktarılması gereken modüller
# RequiredModules = @()

# Bu modül içeri aktarılmadan önce yüklenmesi gereken derlemeler
# RequiredAssemblies = @()

# Bu modül içeri aktarılmadan önce çağıranın ortamında çalıştırılan betik dosyaları (.ps1).
# ScriptsToProcess = @()

# Bu modül içeri aktarılırken yüklenecek tür dosyaları (.ps1xml)
# TypesToProcess = @()

# Bu modül içeri aktarılırken yüklenecek biçim dosyaları (.ps1xml)
# FormatsToProcess = @()

# RootModule/ModuleToProcess içinde belirtilen modülün iç içe modülleri olarak içeri aktarılacak modüller
# NestedModules = @()

# Bu modülden dışarı aktarılacak işlevler için en iyi performansı elde etmek amacıyla joker karakterler kullanmayın ve girdiyi silmeyin. Dışarı aktarılacak işlev yoksa boş bir dizi kullanın.
FunctionsToExport = 'Invoke-WinMaintCleanup'

# Bu modülden dışarı aktarılacak cmdlet'ler için en iyi performansı elde etmek amacıyla joker karakterler kullanmayın ve girdiyi silmeyin. Dışarı aktarılacak cmdlet yoksa boş bir dizi kullanın.
CmdletsToExport = @()

# Bu modülden dışarı aktarılacak değişkenler
# VariablesToExport = @()

# Bu modülden dışarı aktarılacak diğer adlar için en iyi performansı elde etmek amacıyla joker karakterler kullanmayın ve girdiyi silmeyin. Dışarı aktarılacak diğer ad yoksa boş bir dizi kullanın.
AliasesToExport = @()

# Bu modülden dışarı aktarılacak DSC kaynakları
# DscResourcesToExport = @()

# Bu modülle paketlenmiş tüm modüllerin listesi
# ModuleList = @()

# Bu modülle paketlenmiş tüm dosyaların listesi
# FileList = @()

# RootModule/ModuleToProcess içinde belirtilen modüle geçirilecek özel veriler. Bu, PowerShell tarafından kullanılan ek modül meta verilerine sahip bir PSData karma tablosu da içerebilir.
PrivateData = @{

    PSData = @{

        # Bu modüle uygulanan etiketler. Bunlar, çevrimiçi galerilerde modül bulmaya yardımcı olur.
        # Tags = @()

        # Bu modül lisansının URL'si.
        # LicenseUri = ''

        # Bu proje için ana web sitesinin URL'si.
        # ProjectUri = ''

        # Bu modülü temsil eden simgenin URL'si.
        # IconUri = ''

        # Bu modülün sürüm notları
        # ReleaseNotes = ''

        # Bu modülün ön sürüm dizesi
        # Prerelease = ''

        # Modülün yükleme/güncelleştirme/kaydetme işlemleri için kullanıcıdan açık onay gerektirip gerektirmediğini gösteren bayrak
        # RequireLicenseAcceptance = $false

        # Bu modülün dış bağımlı modülleri
        # ExternalModuleDependencies = @()

    } # PSData hashtable'ın sonu

} # PrivateData hashtable'ın sonu

# Bu modülün HelpInfo URI'si
# HelpInfoURI = ''

# Bu modülden dışarı aktarılan komutlar için varsayılan ön ek. Varsayılan ön eki Import-Module -Prefix kullanarak geçersiz kılın.
# DefaultCommandPrefix = ''

}

