# Preuves de livraison et outils maintenus — 19 octobre 2026

Ce document décrit les corrections des sources et procédures après l’audit du
19 octobre. Il ne modifie pas les résultats historiques de
[VALIDATION.md](VALIDATION.md), ne qualifie pas un nouveau binaire et ne vaut
pas décision de construction, signature ou publication.

## Conservation des originaux EAPI043 — A20-D1

L’extrait public [EAPI043](validation-evidence/eapi043.json) reste conservé avec
son empreinte historique. Les deux documents serveur dont cet extrait cite
les empreintes étaient des fichiers courants : `docs/validation.json` et
`docs/etat.md` du projet API. Ils ont changé depuis la collecte.

Les deux originaux exacts correspondant aux empreintes suivantes n’ont pas
été retrouvés parmi les chemins documentaires accessibles examinés :

| Original historique | SHA-256 attendu |
| --- | --- |
| `validation.json` | `8aa48c09a628a604b3103fe3d3fae16ca3463090880ce9bbc58c998030232e83` |
| `etat.md` | `5b216dcc5d42a8b9bffccb11dac264a66a60ced9ed231bb8a09b891357839d79` |

La recherche a porté sur les rapports Android de qualification et les fichiers
portant ces noms dans le projet API accessible. Les sauvegardes externes et
archives de déploiement contenant potentiellement des secrets n’ont pas été
ouvertes. L’absence de copie exacte dans ce périmètre est une limite résiduelle
de preuve ; ce n’est pas un constat sur le fonctionnement actuel du serveur.
Les deux racines accessibles pressenties pour le projet API ne donnent pas
accès à un historique Git de ces deux documents ; aucun ancien état n’a pu
être récupéré par cette voie.

La phrase de conservation générale des originaux dans le registre du
14 octobre doit être lue avec cette réserve ajoutée le 19 octobre. Le reçu
public est inchangé ; il ne remplace pas les deux pièces sources complètes.
Q029 reste **bloqué** : aucune nouvelle observation de production n’est
déduite des corrections documentaires. Les fichiers courants différents ne
doivent pas être renommés « originaux » ni recevoir leurs anciennes empreintes.

Pour une collecte future, l’ordre est : choisir une pièce approuvée, calculer
son empreinte, en conserver une copie datée vérifiée dans les preuves privées,
puis produire l’extrait public expurgé et son empreinte distincte. Conserver le
lien entre ces deux couches sans publier de secrets ni chemins du poste.

[archive_evidence.py](../tools/archive_evidence.py) crée un nouveau dossier
daté, copie un document seulement si ses octets correspondent au SHA-256
attendu et vérifie que la source n’a pas changé pendant la copie. Il refuse
les chemins de credentials/signature et formats privés identifiés, les liens
et reparse points Windows (y compris les jonctions dans les parents),
les empreintes différentes et les écrasements. Son reçu contient le nom,
la taille, le SHA-256 et la date de collecte, sans chemin absolu de la source.

Cette conservation est additive par l’outil : elle ne rend pas les fichiers
invulnérables à une modification externe. L’opérateur doit protéger le dossier
de preuves et vérifier ses empreintes lors d’une relecture. Les exclusions ne
sont pas un détecteur universel de secrets ; n’y soumettre que des documents
approuvés. Aucun original privé réel n’a été copié par la campagne de correction.

## Remplacement du script AAB archivé — A20-D2

Le script ponctuel `release_aab.py` conservé dans le rapport privé
`74016-aab-20261015` est une **preuve historique à conserver, à ne pas
réutiliser comme outil de livraison**. Il n’a pas été modifié : ses assertions
peuvent disparaître avec Python optimisé. Les reçus et livrables historiques
gardent leurs octets et leurs empreintes.

La version maintenue est
[tools/release_aab_safe.py](../tools/release_aab_safe.py). Les préconditions
de source, reçus, empreintes, qualification et comptes de tests utilisent des
contrôles explicites qui lèvent une exception ; leur comportement reste actif
avec `python -O`. Importer le module ne lit aucune configuration et ne lance
aucun processus.

Pour une future livraison locale décidée séparément, l’outil exige :

- Un kit privé explicitement fourni et son commit sélectionné, égal au commit
  complet attendu en argument ; le dépôt doit être propre et son origine
  conforme. Il ne met pas la configuration à jour tout seul.
- Un nom de campagne neuf ; le début de campagne refuse tout dossier de
  rapport ou livraison déjà existant. Les écritures de reçus/journaux sont
  exclusives et ne remplacent pas les preuves précédentes.
- La version lue dans `pubspec.yaml` et la validation locale complète via
  [validate_project.ps1](../tools/validate_project.ps1) : Flutter, polices,
  tous les tests Python, JVM/lints rejoués et contrôles natifs/provenance.
  Les comptes sont recalculés depuis les résultats exécutés, sans nombre
  historique codé en dur. Les timestamps, fichiers JUnit frais et empreintes
  des preuves sont recontrôlés avant la synthèse finale.
- Les étapes `build`, `validate`, `qualify`, `compare`, `export`,
  puis `finalize`. `compare` exige l’APK effectivement retesté correspondant à
  cette campagne ; la comparaison couvre DEX, assets Flutter et bibliothèques
  natives, sans prétendre à l’identité des archives complètes.
- Les reçus de tests complets et leur intégrité avant toute synthèse `PASS`.
  Le kit externe de qualification/signature demeure un prérequis explicite ;
  la nouvelle version ne le remplace pas et ne lit pas ses valeurs secrètes.
  Le statut final reste local : la fonction de publication n’existe pas.

La finalisation relie les entrées de construction au commit, à l’arbre et à
la version courants, puis rapproche les empreintes des sorties, de la
signature, de la qualification, de la comparaison avec l’APK retesté et de
l’association de sources avec les fichiers réels. Le SHA-256 du reçu final
est calculé depuis l’AAB présent. Un reçu d’une autre campagne ne suffit pas
à donner une identité à ce binaire.

Le périmètre AAB impose les sept fichiers attendus et un `SHA256SUMS` complet,
sans doublon ni entrée inconnue. Un inventaire vide ou interrompu est refusé,
même si le sous-processus d’export de sources avait réussi. Un marqueur de fin
d’export, écrit après vérification complète, relie aussi l’inventaire et tous
les hashes. Le schéma du qualificateur conservé a été contrôlé sans exécution :
deux artefacts `aab` et `universal-apk`, avec ces sept noms de fichiers.

L’aide de l’outil décrit les paramètres. Exécuter une étape de construction
ou de signature n’est pas requis pour relire ces corrections. Le cycle réel
de livraison de cette nouvelle version de l’outil n’a pas été exécuté dans
la correction ; les tests utilisent uniquement des fichiers synthétiques et
des processus simulés.

## Vérification des gardes sans action de livraison

```powershell
python -m unittest discover -s tools/tests -p test_release_evidence.py
python -O -m unittest discover -s tools/tests -p test_release_evidence.py
```

Les tests couvrent les écarts de commit, dépôt, état de travail et version,
le refus de finaliser un reçu en échec, l’absence d’action à l’import,
l’absence d’assertion de garde, le refus d’écraser un journal ou campagne,
un payload différent, le refus de résultats JUnit anciens ou de polices
manquants malgré un ancien PASS, la couverture du runner complet, ainsi que
la copie de preuve exacte, son reçu, les chemins privés et jonctions Windows
refusés et le nettoyage limité à la nouvelle copie en échec.
Ils couvrent aussi la substitution de commit, de binaire ou d’archive dans les
reçus, les inventaires vides/partiels/dupliqués et l’absence de marqueur de fin
d’export. Le calcul des empreintes par blocs ne dépend pas de l’API
`hashlib.file_digest` apparue après Python 3.10.

Le contrôleur historique [check_validation.py](../tools/check_validation.py)
reste un vérificateur de structure, liens et empreintes publiques. Son `PASS`
ne certifie pas la vérité d’un texte ou l’état d’un service distant. Une
qualification binaire locale n’atteste ni les tests de code omis par une
option de runner, ni ARM natif, ARM32 dynamique, pages 16 Kio dynamiques,
Google, achats ou production.
