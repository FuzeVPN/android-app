# Qualification documentée — 0.2.10+74016

État daté du 14 octobre 2026. Chaque résultat s’applique uniquement aux versions, environnements et méthodes indiqués. Les preuves publiques sont des extraits expurgés ; leurs originaux restent conservés hors du dépôt.

Bilan : **33 points** — 14 validés, 3 échecs reproduits, 15 bloqués, 1 non applicable.

Référence APK ARM32/ARM64 : `4f1c19706fc4a5da75365ab6148efee1a1a04a6832fdd6d159609853ded59396`.

Sources 74016 conservées par le commit `a5eff1ab577be708e0c0c89b5dc98e5fc96f013b`, après la base publique `9d8172e2524026c6e471dfca7d15df70c0b03b97`. Les mises à jour documentaires et outils d’audit ultérieurs ne constituent pas une nouvelle livraison Android.

[Registre machine](validation.json) · [Audit des 106 composants SPDX](validation-evidence/licenses.json)

| Point | Verdict | Résultat et périmètre |
| --- | --- | --- |
| [Q001](#q001) — Identité, signature et alignements de l’APK | Validé | Package, version, deux ABI, certificat, ZIP et segments LOAD contrôlés. |
| [Q002](#q002) — Correspondance des sources conservées et de la livraison | Validé | Les 166 fichiers archivés correspondent au snapshot Git 74016 ; APK et mapping identifiés par SHA-256. |
| [Q003](#q003) — Analyse et suites applicatives | Validé | 1 814 tests Flutter et 219 tests JVM passent ; analyse propre, aucun lint Android Error/Fatal. |
| [Q004](#q004) — Intégrité des dépendances et authentification OpenSSL | Validé | Gate WireGuard : 16 cas ; intégrité : quatre cas ; signature OpenSSL revérifiée dans un trousseau isolé. |
| [Q005](#q005) — Préservation des moteurs natifs | Validé | Douze bibliothèques système/VPN identiques entre les livraisons 74015 et 74016. |
| [Q006](#q006) — Reconstruction APK bit à bit | Échec reproduit | Deux reconstructions propres donnent des APK différents ; quatre bibliothèques diffèrent, mapping R8 identique. |
| [Q007](#q007) — Reconstruction complète des moteurs depuis leurs sources | Bloqué | Les archives, patches et preuves historiques sont conservés ; aucune reconstruction indépendante complète des moteurs n’a été exécutée dans cet audit. |
| [Q008](#q008) — Formulaires, favoris, titres et statuts accessibles | Validé | Les corrections 74013–74016 sont testées ; huit revues visuelles et 110 changements d’affichage passent. |
| [Q009](#q009) — Tunnels et reprise réseau Android 14–17 | Validé | WireGuard/OpenVPN réels, trafic, coupures d’au moins trente secondes et retour d’arrière-plan passent sur les quatre profils modernes testés. |
| [Q010](#q010) — WireGuard dans les VM Android 12/13 | Échec reproduit | Quatre échecs reproduits : assertion du traducteur sur Android 12, SIGILL/MIDR_EL1 sur Android 13. |
| [Q011](#q011) — Exécution ARM native et ARM32 | Bloqué | Aucun CPU ARM natif ni exécution ARM32 dans les images utilisées. |
| [Q012](#q012) — Exécution complète à pages de 16 Kio | Bloqué | La VM expose PAGE_SIZE=16384 et ARM64, mais deux essais ont atteint la limite mémoire hôte ; aucun verdict applicatif n’en découle. |
| [Q013](#q013) — RELRO et protection des segments ELF | Validé | Aucune plage PT_LOAD writable hors RELRO n’est prise par l’arrondi des pages ; cinq fins RELRO ARM64 ont néanmoins un modulo 16 Kio non nul. |
| [Q014](#q014) — Stockage chiffré, CSR et XKey | Validé | 25 cas d’instrumentation passent : scopes chiffrés, profils, IPv6 stocké, CSR, signatures, renouvellement/révocation locaux, Core et chargement différé. |
| [Q015](#q015) — Chargement WireGuard direct dans le package isolé | Échec reproduit | Le chargement direct de GoBackend sans Flutter produit un SIGILL sur la VM Android 15 dédiée, à l’adresse ARM64 0xa0e50. |
| [Q016](#q016) — Protection matérielle Keystore et variantes constructeur | Bloqué | Les tests VM confirment les contrats cryptographiques, sans démontrer StrongBox/TEE ni des politiques OEM. |
| [Q017](#q017) — DNS, IPv6 et absence de fuite | Bloqué | Les probes 74002 transportent IPv4/IPv6 et résolvent DNS pour leur UID ; aucune recette 74016 complète d’absence de fuite n’est fournie. |
| [Q018](#q018) — Connexion Google native réelle | Bloqué | Les archives Google documentent explicitement l’absence de connexion, inscription et reprise natives réelles. |
| [Q019](#q019) — Associations OAuth dans Google Cloud | Bloqué | Identifiants publics, certificats et audience attendue sont documentés ; les associations Cloud n’ont pas été inspectées. |
| [Q020](#q020) — Achats Google de test historiques | Validé | Annulation, carte refusée, achat approuvé, expiration et réachat sont rapportés pour la recette 74008 du 4 octobre. |
| [Q021](#q021) — Acquittement, renouvellement et RTDN historiques | Validé | Le reçu API035 rapporte acquittement durable, renouvellement et observations RTDN après la recette de test. |
| [Q022](#q022) — RTDN répétés/désordonnés et cycles d’achat complets | Bloqué | Pas de preuve réelle complète pour pending, restauration invitée sur un autre appareil, ordre inversé/redélivrance et cycle de révocation. |
| [Q023](#q023) — Offre freetest réelle et éligibilité Play | Bloqué | Sélection et phases sont testées côté client ; aucune souscription freetest réelle ne figure dans la livraison du 11 octobre. |
| [Q024](#q024) — Claim invité et continuité VPN historiques | Validé | Le rapport 74008 décrit un claim réel conservant session, appareil et WireGuard, puis une reconnexion OpenVPN après redémarrage. |
| [Q025](#q025) — Turnstile natif et finalisation sous défi obligatoire | Bloqué | Le formulaire Android ne fournit pas de token Turnstile ; le défi obligatoire n’est pas un parcours natif qualifié. |
| [Q026](#q026) — Tuile et reconnexion du profil validé | Bloqué | Les profils de tuile sont testés en stockage ; aucune recette système 74016 complète des deux protocoles n’est identifiée. |
| [Q027](#q027) — VPN permanent, lockdown, redémarrage et Doze | Bloqué | Les tests d’arrière-plan passent ; aucune preuve complète 74016 de lockdown, redémarrage/déverrouillage et veille prolongée. |
| [Q028](#q028) — Révocation et renouvellement OpenVPN réels | Bloqué | Les cinq scénarios d’identité locaux passent ; le certificat J-7/expiré et /renew réels ne sont pas exercés pour 74016. |
| [Q029](#q029) — Backend, déploiement et traitements serveur | Bloqué | Le reçu API043 atteste une livraison datée du 11 octobre ; pas de recontrôle live ni d’audit des journaux, conservation et destinataires serveur. |
| [Q030](#q030) — Licences des 106 composants et NOASSERTION | Validé | 106 composants examinés ; 23 déclarations/93 conclusions initialement inconnues deviennent une déclaration et 21 conclusions NOASSERTION expliquées. |
| [Q031](#q031) — Polices et fournisseur JDK | Validé | Archivo et les deux IBM Plex Mono sont identiques au commit Google Fonts e9678a5… ; le JDK est Temurin 17.0.20.1+1. |
| [Q032](#q032) — Déclarations de périmètre, licences et marques | Non applicable | Les limites de publication de sources, de marque et de valeur probante d’un test sont des frontières documentaires, pas des tests manquants. |
| [Q033](#q033) — Inventaire complet de l’APK optimisé | Bloqué | L’inventaire de sources est rapproché des entrées et notices ; la présence exhaustive des transitifs et internes Flutter dans l’APK n’est pas établie. |

<a id="q001"></a>
## Q001 — Identité, signature et alignements de l’APK

**Validé** — Package, version, deux ABI, certificat, ZIP et segments LOAD contrôlés.

**Périmètre :** APK local 74016 signé avec la clé d’envoi ; ARM64 LOAD ≥16 Kio, ARM32 ≥4 Kio. Pas de signature Play attestée.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016APK](validation-evidence/e74016apk.json).

<a id="q002"></a>
## Q002 — Correspondance des sources conservées et de la livraison

**Validé** — Les 166 fichiers archivés correspondent au snapshot Git 74016 ; APK et mapping identifiés par SHA-256.

**Périmètre :** Traçabilité de la construction conservée, sans affirmation de reconstruction indépendante bit à bit.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016TRACE](validation-evidence/e74016trace.json).

<a id="q003"></a>
## Q003 — Analyse et suites applicatives

**Validé** — 1 814 tests Flutter et 219 tests JVM passent ; analyse propre, aucun lint Android Error/Fatal.

**Périmètre :** Contrôles automatisés du client. Trois constats lint existants restent distincts d’erreurs bloquantes.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016CHECKS](validation-evidence/e74016checks.json).

<a id="q004"></a>
## Q004 — Intégrité des dépendances et authentification OpenSSL

**Validé** — Gate WireGuard : 16 cas ; intégrité : quatre cas ; signature OpenSSL revérifiée dans un trousseau isolé.

**Périmètre :** Validité cryptographique contre les clés publiques conservées et intégrité contre les verrous revus.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EPROVENANCE](validation-evidence/eprovenance.json), [E74016CHECKS](validation-evidence/e74016checks.json).

<a id="q005"></a>
## Q005 — Préservation des moteurs natifs

**Validé** — Douze bibliothèques système/VPN identiques entre les livraisons 74015 et 74016.

**Périmètre :** Exclut libapp.so, qui contient le correctif Dart 74016.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016TRACE](validation-evidence/e74016trace.json).

<a id="q006"></a>
## Q006 — Reconstruction APK bit à bit

**Échec reproduit** — Deux reconstructions propres donnent des APK différents ; quatre bibliothèques diffèrent, mapping R8 identique.

**Périmètre :** Même snapshot, outils épinglés et entrées natives précompilées ; sorties séparées, caches de téléchargement partagés.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EREBUILD](validation-evidence/erebuild.json).

**Pour compléter :** Stabiliser les chemins et autres entrées de compilation, puis répéter deux builds propres. Aucun moteur ou APK livré n’a été remplacé.

<a id="q007"></a>
## Q007 — Reconstruction complète des moteurs depuis leurs sources

**Bloqué** — Les archives, patches et preuves historiques sont conservés ; aucune reconstruction indépendante complète des moteurs n’a été exécutée dans cet audit.

**Périmètre :** La double reconstruction Q006 réutilise les entrées natives verrouillées.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EPROVENANCE](validation-evidence/eprovenance.json), [EREBUILD](validation-evidence/erebuild.json).

**Pour compléter :** Reconstituer les outils/options exacts de préparation OpenSSL/Go et reconstruire les préfixes et l’AAR dans une recette distincte.

<a id="q008"></a>
## Q008 — Formulaires, favoris, titres et statuts accessibles

**Validé** — Les corrections 74013–74016 sont testées ; huit revues visuelles et 110 changements d’affichage passent.

**Périmètre :** Retest 74016 en VM ; mots des statuts à 320/360 dp et 200 %, thèmes clair/sombre. Aucun engagement sur toutes les légendes longues.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016QA](validation-evidence/e74016qa.json), [E74016CHECKS](validation-evidence/e74016checks.json).

<a id="q009"></a>
## Q009 — Tunnels et reprise réseau Android 14–17

**Validé** — WireGuard/OpenVPN réels, trafic, coupures d’au moins trente secondes et retour d’arrière-plan passent sur les quatre profils modernes testés.

**Périmètre :** APK 74016 ARM64 traduit, Android 14–17 téléphone ; périmètre exact du retest.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016QA](validation-evidence/e74016qa.json).

<a id="q010"></a>
## Q010 — WireGuard dans les VM Android 12/13

**Échec reproduit** — Quatre échecs reproduits : assertion du traducteur sur Android 12, SIGILL/MIDR_EL1 sur Android 13.

**Périmètre :** Pont ARM sur hôte x86_64 ; ces résultats ne démontrent pas un défaut sur CPU ARM natif.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016QA](validation-evidence/e74016qa.json).

**Pour compléter :** Exécuter la même livraison sur un environnement ARM natif Android 12/13 ; les quatre reproductions originales restent arrêtées et intactes.

<a id="q011"></a>
## Q011 — Exécution ARM native et ARM32

**Bloqué** — Aucun CPU ARM natif ni exécution ARM32 dans les images utilisées.

**Périmètre :** Les contrôles ELF des deux ABI sont validés ; les parcours dynamiques décrits exécutent ARM64 traduit.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016QA](validation-evidence/e74016qa.json), [E74016APK](validation-evidence/e74016apk.json).

**Pour compléter :** Environnement local exécutant ARM32 et environnement ARM64 natif Android 12/13 ; indisponibles dans le périmètre VM retenu.

<a id="q012"></a>
## Q012 — Exécution complète à pages de 16 Kio

**Bloqué** — La VM expose PAGE_SIZE=16384 et ARM64, mais deux essais ont atteint la limite mémoire hôte ; aucun verdict applicatif n’en découle.

**Périmètre :** 1536 Mo invités, QEMU arrêté au seuil conservateur de 4 000 000 000 octets ; lancement tenté hors ligne avec l’APK signé.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EVM16K](validation-evidence/evm16k.json), [E74016APK](validation-evidence/e74016apk.json).

**Pour compléter :** VM 16 Kio exécutant ARM64 et tenant sous le plafond mémoire, puis tests de démarrage, chargement natif et tunnels. Pas de qualification dynamique complète déclarée.

<a id="q013"></a>
## Q013 — RELRO et protection des segments ELF

**Validé** — Aucune plage PT_LOAD writable hors RELRO n’est prise par l’arrondi des pages ; cinq fins RELRO ARM64 ont néanmoins un modulo 16 Kio non nul.

**Périmètre :** Inspection indépendante des plages ELF, selon l’arrondi du linker Bionic ; padding entre LOAD séparés. Le seul modulo ne prouve pas un chevauchement.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Décodage ELF des quatorze bibliothèques, calcul des pages protégées et intersection avec les plages LOAD writable ; comparaison au code Bionic cité dans la preuve.

**Date :** 2026-10-14

**Preuves :** [E74016APK](validation-evidence/e74016apk.json).

<a id="q014"></a>
## Q014 — Stockage chiffré, CSR et XKey

**Validé** — 25 cas d’instrumentation passent : scopes chiffrés, profils, IPv6 stocké, CSR, signatures, renouvellement/révocation locaux, Core et chargement différé.

**Périmètre :** APK de test isolé com.fuzevpn.recoverytest ; Android 15, ARM64 traduit, pages 4 Kio. Clés synthétiques non exportables ; aucun tunnel réel.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Exécution des huit classes existantes ; le diagnostic de chargement WireGuard supplémentaire est séparé en Q015.

**Date :** 2026-10-14

**Preuves :** [EVMINSTRUMENT](validation-evidence/evminstrument.json).

<a id="q015"></a>
## Q015 — Chargement WireGuard direct dans le package isolé

**Échec reproduit** — Le chargement direct de GoBackend sans Flutter produit un SIGILL sur la VM Android 15 dédiée, à l’adresse ARM64 0xa0e50.

**Périmètre :** Diagnostic isolé via pont ARM ; ne remplace ni n’invalide par extrapolation les tunnels de l’APK signé attestés par Q009.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EVMINSTRUMENT](validation-evidence/evminstrument.json), [ESIGILL35](validation-evidence/esigill35.json).

**Pour compléter :** Contrôler ce parcours sur CPU ARM natif et comparer l’initialisation du processus isolé au parcours Flutter ; aucun patch moteur fondé sur ce seul pont.

<a id="q016"></a>
## Q016 — Protection matérielle Keystore et variantes constructeur

**Bloqué** — Les tests VM confirment les contrats cryptographiques, sans démontrer StrongBox/TEE ni des politiques OEM.

**Périmètre :** Q014 est une preuve fonctionnelle en VM, sans attestation matérielle ou HyperOS/One UI.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EVMINSTRUMENT](validation-evidence/evminstrument.json).

**Pour compléter :** Environnement disposant de l’implémentation matérielle/OEM ciblée et inspection de KeyInfo/attestation adaptée.

<a id="q017"></a>
## Q017 — DNS, IPv6 et absence de fuite

**Bloqué** — Les probes 74002 transportent IPv4/IPv6 et résolvent DNS pour leur UID ; aucune recette 74016 complète d’absence de fuite n’est fournie.

**Périmètre :** Résultats historiques API36 x86_64, instants échantillonnés. Les échecs ICMP IPv6 intermédiaires restent visibles dans l’extrait.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74002NETWORK](validation-evidence/e74002network.json), [E74016QA](validation-evidence/e74016qa.json).

**Pour compléter :** Recette 74016 dédiée aux résolveurs, UID, routes IPv4/IPv6 et trafic hors tunnel ; ne pas assimiler ping réussi et absence de fuite.

<a id="q018"></a>
## Q018 — Connexion Google native réelle

**Bloqué** — Les archives Google documentent explicitement l’absence de connexion, inscription et reprise natives réelles.

**Périmètre :** Code, SDK et tests simulés présents ; aucune nouvelle interaction Google autorisée pour cet audit.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EGOOGLE](validation-evidence/egoogle.json).

**Pour compléter :** Compte Google de recette et parcours Credential Manager réels sur l’APK/signature ciblés.

<a id="q019"></a>
## Q019 — Associations OAuth dans Google Cloud

**Bloqué** — Identifiants publics, certificats et audience attendue sont documentés ; les associations Cloud n’ont pas été inspectées.

**Périmètre :** Un certificat ou un client ID fourni par le propriétaire ne démontre pas la configuration Cloud correspondante.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EGOOGLE](validation-evidence/egoogle.json).

**Pour compléter :** Export ou lecture autorisée des associations package/certificat et audience de chaque signature ciblée.

<a id="q020"></a>
## Q020 — Achats Google de test historiques

**Validé** — Annulation, carte refusée, achat approuvé, expiration et réachat sont rapportés pour la recette 74008 du 4 octobre.

**Périmètre :** APK QA x86_64/R8 signé avec certificat de développement et paiements explicitement de test ; pas une recette 74016.

**Environnement :** VM Android historique, recette Google testeur de licence

**Méthode :** Rapprochement du rapport client, étapes de paiement conservées et empreinte de l’APK QA.

**Date :** 2026-10-04

**Preuves :** [E74008PLAY](validation-evidence/e74008play.json).

<a id="q021"></a>
## Q021 — Acquittement, renouvellement et RTDN historiques

**Validé** — Le reçu API035 rapporte acquittement durable, renouvellement et observations RTDN après la recette de test.

**Périmètre :** Observation datée du 4 octobre ; pas de preuve de tous les cycles financiers ni de l’état actuel API043.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-04

**Preuves :** [EAPI035](validation-evidence/eapi035.json), [E74008PLAY](validation-evidence/e74008play.json).

<a id="q022"></a>
## Q022 — RTDN répétés/désordonnés et cycles d’achat complets

**Bloqué** — Pas de preuve réelle complète pour pending, restauration invitée sur un autre appareil, ordre inversé/redélivrance et cycle de révocation.

**Périmètre :** Les tests simulés et compteurs RTDN ne remplacent pas ces parcours.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EAPI035](validation-evidence/eapi035.json), [E74008PLAY](validation-evidence/e74008play.json).

**Pour compléter :** Recette Google de test dédiée et preuves serveur expurgées pour chaque transition ; aucune nouvelle opération fournisseur dans cet audit.

<a id="q023"></a>
## Q023 — Offre freetest réelle et éligibilité Play

**Bloqué** — Sélection et phases sont testées côté client ; aucune souscription freetest réelle ne figure dans la livraison du 11 octobre.

**Périmètre :** Deux semaines gratuites reçues de Play, fallback normal et jeton exact : contrat client ; pas de disponibilité commerciale attestée.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EGOOGLE](validation-evidence/egoogle.json), [E74016CHECKS](validation-evidence/e74016checks.json).

**Pour compléter :** Configuration Play inspectée et recette testeur éligible/inéligible, deux plans, prix/offre absents et transitions serveur.

<a id="q024"></a>
## Q024 — Claim invité et continuité VPN historiques

**Validé** — Le rapport 74008 décrit un claim réel conservant session, appareil et WireGuard, puis une reconnexion OpenVPN après redémarrage.

**Périmètre :** Recette historique ; le claim pendant OpenVPN déjà actif n’a pas été exécuté.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-04

**Preuves :** [E74008PLAY](validation-evidence/e74008play.json), [EAPI035](validation-evidence/eapi035.json).

<a id="q025"></a>
## Q025 — Turnstile natif et finalisation sous défi obligatoire

**Bloqué** — Le formulaire Android ne fournit pas de token Turnstile ; le défi obligatoire n’est pas un parcours natif qualifié.

**Périmètre :** L’absence de défi dans les observations serveur datées ne prouve pas son support Android lorsqu’il est exigé.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EGOOGLE](validation-evidence/egoogle.json), [EAPI043](validation-evidence/eapi043.json).

**Pour compléter :** Parcours natif du défi, politique serveur ciblée connue et recette de finalisation sans contournement.

<a id="q026"></a>
## Q026 — Tuile et reconnexion du profil validé

**Bloqué** — Les profils de tuile sont testés en stockage ; aucune recette système 74016 complète des deux protocoles n’est identifiée.

**Périmètre :** Les deux tests QuickTileProfile passent en VM ; ils n’actionnent pas la tuile Android avec un tunnel réel.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EVMINSTRUMENT](validation-evidence/evminstrument.json), [E74016QA](validation-evidence/e74016qa.json).

**Pour compléter :** Recette 74016 de la tuile : reprise et arrêt des deux protocoles, Flutter détaché et absence d’appel API de préparation.

<a id="q027"></a>
## Q027 — VPN permanent, lockdown, redémarrage et Doze

**Bloqué** — Les tests d’arrière-plan passent ; aucune preuve complète 74016 de lockdown, redémarrage/déverrouillage et veille prolongée.

**Périmètre :** HOME et coupure réseau ne suffisent pas à établir un kill switch ou une reprise après démarrage système.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [E74016QA](validation-evidence/e74016qa.json), [E74002NETWORK](validation-evidence/e74002network.json).

**Pour compléter :** Recette système dédiée en VM avec observation du trafic hors tunnel, verrouillage, redémarrage et Doze.

<a id="q028"></a>
## Q028 — Révocation et renouvellement OpenVPN réels

**Bloqué** — Les cinq scénarios d’identité locaux passent ; le certificat J-7/expiré et /renew réels ne sont pas exercés pour 74016.

**Périmètre :** Tests d’instrumentation sur données synthétiques, sans appel serveur ni annulation de droits.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EVMINSTRUMENT](validation-evidence/evminstrument.json).

**Pour compléter :** Identité et serveur de recette contrôlés pour expiration, CSR repris, panne API et révocation réelle.

<a id="q029"></a>
## Q029 — Backend, déploiement et traitements serveur

**Bloqué** — Le reçu API043 atteste une livraison datée du 11 octobre ; pas de recontrôle live ni d’audit des journaux, conservation et destinataires serveur.

**Périmètre :** Lecture seule des contrats et reçus locaux. Turnstile des inscriptions était désactivé dans cet état daté ; le Web guest checkout avait sa politique distincte.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EAPI043](validation-evidence/eapi043.json), [EPERIMETER](validation-evidence/eperimeter.json).

**Pour compléter :** Preuves opérateur actuelles et audit ciblé des traitements du service complet ; aucun déploiement ou changement de configuration dans ce chantier.

<a id="q030"></a>
## Q030 — Licences des 106 composants et NOASSERTION

**Validé** — 106 composants examinés ; 23 déclarations/93 conclusions initialement inconnues deviennent une déclaration et 21 conclusions NOASSERTION expliquées.

**Périmètre :** Déclarations de composants, sources et prérequis. Les résidus désignent des agrégats/custom terms ou l’expression non établie de Public Domain ; copyright agrégé séparé.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [ELICENSES](validation-evidence/licenses.json).

<a id="q031"></a>
## Q031 — Polices et fournisseur JDK

**Validé** — Archivo et les deux IBM Plex Mono sont identiques au commit Google Fonts e9678a5… ; le JDK est Temurin 17.0.20.1+1.

**Périmètre :** Comparaison d’octets et métadonnées installées ; ne reconstitue pas la date/révision historique du téléchargement initial.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EFONTS](validation-evidence/efonts.json), [EJDK](validation-evidence/ejdk.json).

<a id="q032"></a>
## Q032 — Déclarations de périmètre, licences et marques

**Non applicable** — Les limites de publication de sources, de marque et de valeur probante d’un test sont des frontières documentaires, pas des tests manquants.

**Périmètre :** Pas de certificat juridique global, de permission de marque ou d’approbation Play déduits de l’audit. Les constats historiques conservent leurs versions.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [EPERIMETER](validation-evidence/eperimeter.json), [ELICENSES](validation-evidence/licenses.json).

<a id="q033"></a>
## Q033 — Inventaire complet de l’APK optimisé

**Bloqué** — L’inventaire de sources est rapproché des entrées et notices ; la présence exhaustive des transitifs et internes Flutter dans l’APK n’est pas établie.

**Périmètre :** Les 106 composants incluent tests et prérequis non embarqués ; résolution Gradle/Pub et reachability R8 sont distinctes.

**Environnement :** Poste de reconstruction Windows ; preuves datées conservées

**Méthode :** Inspection des entrées et des preuves indiquées

**Date :** 2026-10-14

**Preuves :** [ELICENSES](validation-evidence/licenses.json), [E74016APK](validation-evidence/e74016apk.json).

**Pour compléter :** Inventaire du livrable optimisé avec classes conservées, liaisons natives, internes du moteur Flutter et notices correspondantes.

## Vérification

```powershell
python tools/check_validation.py
python -m unittest discover -s tools/tests -p 'test_check_validation.py'
```

Le contrôle vérifie les liens locaux, les empreintes publiques, les versions associées, les comptes de tests, les verdicts, chaque occurrence inventoriée et chaque champ NOASSERTION du SBOM. Il ne réexécute pas les parcours historiques ni les services distants.
