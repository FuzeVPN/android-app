# FuzeVPN pour Android

[English](README.md)

L'application FuzeVPN pour Android : tunnels WireGuard et OpenVPN, trente
langues, abonnements Google Play et accès invité. Elle fonctionne sur
**Android 8.0 (API 26) ou ultérieur** ; son package est `com.fuzevpn`.

Ce dépôt contient le code source de l'application et ses entrées natives de
compilation revues. Le backend et l'infrastructure VPN FuzeVPN sont des
services distincts, absents de ce dépôt.

## Télécharger

Version actuelle : **0.2.11** (build 74018).

Des APK signés sont joints à chaque
[release GitHub](https://github.com/FuzeVPN/android-app/releases), avec leurs
empreintes SHA-256 et l'archive des sources correspondantes. Aucun App Bundle
n'est publié. Le [guide des APK](docs/APK.fr.md) indique quel fichier convient
à votre téléphone et comment le vérifier avant de l'installer.

Si vous avez installé FuzeVPN depuis Google Play, continuez à le mettre à jour
par Google Play : les versions Google Play et GitHub sont signées avec des clés
différentes, l'une ne peut pas mettre à jour l'autre.

## Nouveautés de la 0.2.11

- La carte de connexion indique « Préparation » dès le tap sur « Se connecter »,
  et chaque changement d'emplacement OpenVPN affiche sa progression, étape par
  étape.
- Depuis Android 11, le VPN permanent revient seul après un arrêt de l'app par
  un plantage ou par Android, même quand la tuile des réglages rapides ou un
  autre composant relance l'app en premier (Android 10 : sans ce secours,
  non testé).
- OpenVPN ne coupe plus les transferts quand le téléphone repasse en Wi-Fi.
- Android 11 : plus de plantage au démarrage ; Android 8 à 11 : plus de
  plantage quand le service VPN est arrêté juste après son démarrage.
- Avec un texte très agrandi (200 %), les dialogues de confirmation ne coupent
  plus les mots.
- Moins de travail pendant la connexion et sur l'onglet Compte.

Détails dans les [notes de version](docs/RELEASE_NOTES.md).

## Fonctionnalités

- Tunnels WireGuard et OpenVPN intégrés aux services VPN Android.
- Mention VPN dédiée avec accord explicite avant la permission Android et
  possibilité de refuser. Voir le [parcours à filmer](docs/VPN_DISCLOSURE.md).
- Emplacements par pays/ville, recherche, favoris et changement confirmé.
- Trente langues, thèmes clair/sombre et interfaces de droite à gauche.
- Diagnostics soumis au consentement et stockage local chiffré.
- Abonnements Google Play, prix localisés et restauration des achats.
- Compte invité, création facultative d'un compte et connexion Google.
- Depuis les réglages invités, une fenêtre permet de se connecter à un autre
  compte après vérification. Elle ne convertit pas l'invité et ne transfère
  aucun abonnement ; la création de compte reste une action distincte.

Release/profile utilisent l'origine API de production ; le remplacement
d'origine est réservé au debug. Lire les guides avant tout essai réseau.

## Compiler depuis les sources

Matrice revue : Flutter **3.47.8** (Dart **3.13.7**), JDK **17**, Android Platform **36**,
NDK **28.2.13676358** et CMake **3.22.1**. Le projet épingle Gradle **9.8.2**,
Android Gradle Plugin **9.3.0** et Kotlin **2.3.20**.

Installer les outils, définir `JAVA_HOME` et `ANDROID_HOME`, puis créer son
propre `android/local.properties` ignoré avec les chemins SDK/Flutter.
Depuis la racine :

```powershell
flutter pub get
python tools/generate_translations.py --check --require-all
flutter analyze --no-pub
flutter test --no-pub
flutter build apk --debug --no-pub --split-per-abi --target-platform android-arm64,android-arm,android-x64 --android-project-arg=fuzevpn.usePatchedWireGuardAar=true
```

Release et profile exigent l'AAR WireGuard local approuvé avec
`fuzevpn.usePatchedWireGuardAar=true`. Conserver cet AAR, les bibliothèques
statiques, archives sources, patches et manifestes : le build les contrôle.
Aucune clé de signature n'est incluse ou nécessaire pour consulter les sources.

Les contrôles natifs attestent l'intégrité face aux manifestes revus. Ils
n'établissent pas seuls une reconstruction APK bit à bit. SDK et dépendances
Maven/Pub se préparent séparément.

## Documentation

| Guide | Contenu |
| --- | --- |
| [Guide des APK](docs/APK.fr.md) | Quel APK pour quel téléphone, installation, vérifications |
| [Notes de version](docs/RELEASE_NOTES.md) | Changements par version et limites de validation |
| [Corrections de l’audit complet](docs/AUDIT_CORRECTIONS_20261029.md) | 81 écarts, chaîne d’outils, deux validations locales et limites |
| [Corrections du réaudit](docs/AUDIT_CORRECTIONS_20261028.md) | Onze écarts, validation locale et identité des compilations de contrôle |
| [Dernier SPDX release (28/10)](docs/SBOM.release.corrections-20261028.spdx.json) | Résolution des dépendances et AAB exact non signé de l’arbre de travail, produit avant l’inventaire des composants natifs ([guide des SBOM release](docs/SBOM.release.md)) |
| [Développement](docs/DEVELOPMENT.md) | Outils, compilation, tests et qualification sur appareil |
| [Architecture](docs/ARCHITECTURE.md) | Comportement, stockage, tunnels et API attendue |
| [Dépendances natives](docs/NATIVE_DEPENDENCIES.md) | Révisions, patches, intégrité et reconstruction |
| [Sources](docs/SOURCE_DISTRIBUTION.md) | Export complet et limites de correspondance binaire |
| [Google Play](docs/PLAY_BILLING.md) | Achat, restauration, propriétaire et exigences serveur |
| [Invités](docs/GUEST_ACCOUNTS.md) | Sessions invitées, création de compte et connexion distincte |
| [Connexion Google](docs/GOOGLE_AUTH.md) | Credential Manager et contrat OAuth serveur |
| [Licences](LICENSING.md) | Périmètre MPL, exceptions et marques |
| [Notices tierces](THIRD_PARTY_NOTICES.md) | Licences et provenance des composants |
| [Inventaire SPDX historique (14/10)](docs/SBOM.spdx.json) | Inventaire de sources du 14/10, avec l’ancien moteur WireGuard ; versions actuelles dans le [guide des SBOM release](docs/SBOM.release.md) et les [notices tierces](THIRD_PARTY_NOTICES.md) |

## Qualité et audits

Le [registre de qualification](docs/VALIDATION.md) indique ce qui a été testé,
sur quelle version et dans quel environnement, avec ses limites. Les preuves
d’une version ou d’un service ne sont pas attribuées à un autre environnement.

- Audit de qualification du 14 octobre 2026 : [Q001](docs/VALIDATION.md#q001), [Q002](docs/VALIDATION.md#q002), [Q003](docs/VALIDATION.md#q003), [Q004](docs/VALIDATION.md#q004), [Q006](docs/VALIDATION.md#q006), [Q009](docs/VALIDATION.md#q009), [Q018](docs/VALIDATION.md#q018), [Q019](docs/VALIDATION.md#q019), [Q020](docs/VALIDATION.md#q020), [Q021](docs/VALIDATION.md#q021), [Q023](docs/VALIDATION.md#q023), [Q030](docs/VALIDATION.md#q030), [Q031](docs/VALIDATION.md#q031), [Q032](docs/VALIDATION.md#q032), [Q033](docs/VALIDATION.md#q033).
  Il documente les résultats par version : tunnels et reprise 74016 sur les VM
  Android 14–17, achats/RTDN historiques 74008/API035, et blocages Google
  natif, freetest réel et ARM natif.
- Les [corrections de l’audit complet du 28 octobre 2026](docs/AUDIT_CORRECTIONS_20261029.md)
  traitent 81 écarts (1 P1, 9 P2, 71 P3) et portent la chaîne d’outils à
  Flutter 3.47.8 et Gradle 9.8.2.
- Les [corrections du réaudit du 28 octobre 2026](docs/AUDIT_CORRECTIONS_20261028.md)
  corrigent onze écarts de sources et d’outillage. Les [corrections du 19 octobre](docs/AUDIT_CORRECTIONS_20261019.md)
  et les preuves de qualification antérieures gardent leurs dates et limites.
- Voir les [limites des preuves et outils maintenus](docs/RELEASE_EVIDENCE.md),
  dont la réserve sur les deux originaux historiques non retrouvés.

## Licence et contributions

Le code original de l'application est publié sous **MPL-2.0**, sauf notice
existante différente dans un fichier. Les tiers, polices, illustrations, SDK
et outils gardent leurs propres conditions. Les SDK Google empêchent de
présenter l'APK complet comme un ensemble entièrement libre.

Les noms/logos FuzeVPN et Google ont des règles de marque distinctes. La
licence du logiciel ne permet pas de présenter un fork comme une application
officielle FuzeVPN. Voir [LICENSE](LICENSE), [LICENSING.md](LICENSING.md),
[CONTRIBUTING.md](CONTRIBUTING.md) et [SECURITY.md](SECURITY.md).
