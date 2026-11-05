# Quel APK installer ?

[English](APK.md)

Chaque [release GitHub](https://github.com/FuzeVPN/android-app/releases) de
FuzeVPN propose trois APK signés. Ils contiennent la même application ; seul le
type de processeur visé change.

| Fichier | Pour quels appareils |
| --- | --- |
| `FuzeVPN-<version>-arm64-v8a.apk` | **Presque tous les téléphones et tablettes** récents (processeur ARM 64 bits). Commencez par celui-ci. |
| `FuzeVPN-<version>-armeabi-v7a.apk` | Téléphones anciens ou d'entrée de gamme sous Android 32 bits, dont beaucoup d'appareils « Android Go ». À prendre si le premier fichier ne s'installe pas. |
| `FuzeVPN-<version>-x86_64.apk` | Émulateurs Android sur PC, certains Chromebooks et tablettes à processeur Intel/AMD. |

Les trois demandent **Android 8.0 ou ultérieur**. Pour voir votre version :
*Paramètres › À propos du téléphone › Version d'Android*. Android 7 et les
versions plus anciennes ne sont pas prises en charge.

## Connaître le type de processeur

Dans la plupart des cas, inutile de chercher : installez `arm64-v8a`. Si
FuzeVPN n'est pas déjà installé depuis Google Play et qu'Android répond
« Application non installée » ou « incompatible », installez `armeabi-v7a`.
S'il est installé depuis Google Play, voir
[Google Play ou GitHub ?](#google-play-ou-github-) plus bas.

Pour vérifier avant :

- une application d'information comme *CPU-Z* ou *Device Info HW* affiche les
  ABI prises en charge (`arm64-v8a`, `armeabi-v7a` ou `x86_64`) ;
- avec un ordinateur et ADB : `adb shell getprop ro.product.cpu.abi`.

## Installer

1. Téléchargez l'APK depuis la release, directement sur le téléphone.
2. Ouvrez le fichier. Android demande d'autoriser l'installation depuis cette
   source (navigateur ou gestionnaire de fichiers) : acceptez pour cette source
   seulement.
3. Installez, puis ouvrez FuzeVPN et connectez-vous.

Pour mettre à jour, installez l'APK de la nouvelle release par-dessus :
l'application et votre session sont conservées.

## Google Play ou GitHub ?

Les versions Google Play et GitHub sont signées avec des clés différentes.
Android refuse donc de remplacer l'une par l'autre (« Application non
installée » ou « conflit avec un package existant »).

- Installé depuis Google Play : continuez à mettre à jour par Google Play.
- Pour passer de l'une à l'autre : désinstallez d'abord FuzeVPN, installez
  l'autre version, puis reconnectez-vous à votre compte. Un invité sans compte
  restaure son abonnement Google Play avec « Déjà acheté ? » sur l'écran
  d'accueil.

## Vérifier un APK (facultatif)

Chaque release contient un fichier `SHA256SUMS.txt`. Comparez l'empreinte du
fichier téléchargé :

- Windows : `certutil -hashfile FuzeVPN-<version>-arm64-v8a.apk SHA256`
- macOS : `shasum -a 256 FuzeVPN-<version>-arm64-v8a.apk`
- Linux : `sha256sum FuzeVPN-<version>-arm64-v8a.apk`

Le certificat de signature des APK GitHub a cette empreinte SHA-256 :

```
F6:F8:56:A1:A5:CD:9E:10:41:EB:84:A8:75:7E:D6:E6:C3:B7:46:39:18:48:DA:E9:9C:FA:93:0F:C2:C9:93:E3
```

Avec les outils Android SDK, `apksigner verify --print-certs <fichier.apk>`
doit afficher la même valeur, en minuscules et sans deux-points :
`Signer #1 certificate SHA-256 digest: f6f856a1a5cd9e1041eb84a8757ed6e6c3b746391848dae99cfa930fc2c993e3`.

## Sources

Chaque release joint l'archive des sources correspondant à ses APK, produite
par `tools/package_android_sources.py` (voir [SOURCE_DISTRIBUTION.md](SOURCE_DISTRIBUTION.md)).
Pour compiler vous-même, suivez le [README](../README.fr.md#compiler-depuis-les-sources).
