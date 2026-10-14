# Verrou de provenance native Android

Audit de qualification du 14 octobre 2026 : [Q004](../../docs/VALIDATION.md#q004), [Q006](../../docs/VALIDATION.md#q006), [Q007](../../docs/VALIDATION.md#q007).


`bundle.sha256` fige les 1 848 fichiers du bundle
`app/src/main/cpp/third_party` : sources Core, en-têtes, bibliothèques statiques,
archive source OpenSSL, manifestes internes et métadonnées. Le SHA-256 de
cet inventaire est fixé dans `NativeBundlePolicy.java`, hors du bundle importé.
Modifier un fichier et régénérer son manifeste interne ne l’approuve donc pas.

Le bundle courant utilise OpenSSL 3.5.9, reconstruit pour les trois ABI avec
NDK 28.2.13676358 et API 26. L’archive officielle, sa signature détachée et
les certificats OpenSSL publiés sont conservés dans `openssl/source/`.
Les signatures de l’archive et du tag ont été vérifiées lors de cette mise
à jour ; la politique hors ligne contrôle ensuite leurs octets avec le
reste du bundle. Les preuves de cette revue sont sous
`build/reports/audit-fixes-2026-09-30/native/` à la racine du projet.

`core-marker.txt` et `import-metadata.json` servent de modèles à l’importateur.
Le résultat de leur copie est lui-même vérifié par l’inventaire. Aucun moteur
natif ni téléchargement n’est exécuté par ce contrôle.

## Contrôles et import

La même implémentation Java 17 est utilisée par Gradle, CMake et PowerShell.
Elle contrôle l’empreinte de l’inventaire, tous les fichiers attendus et
l’absence de fichiers supplémentaires. Elle refuse les chemins ambigus ou
sortants, les doublons de casse et les liens. `verifyNativeBundle` n’a pas de
sorties Gradle : il s’exécute aussi lorsque la compilation native est déjà à
jour. Une configuration CMake directe applique le même contrôle et refuse
les chemins de dépendances non revus.

L’import utilise par défaut `app/src/main/cpp/third_party`. Il refuse une
destination existante. `-DestinationRoot` permet un essai dans un répertoire
isolé inexistant. Les préfixes entrants sont contrôlés avant la copie, puis
le bundle complet est contrôlé avant le déplacement de son répertoire
temporaire voisin vers la destination. Voir
[NATIVE_DEPENDENCIES.md](../../docs/NATIVE_DEPENDENCIES.md) pour les commandes,
versions, licences et étapes de livraison.

## Mise à jour d’une dépendance

Ce verrou détecte la dérive d’un bundle revu ; il ne démontre pas à lui seul
qu’un binaire a été produit par une source donnée. Une mise à jour nécessite :

1. Conserver les anciens fichiers et leurs empreintes pour la revue.
2. Vérifier les références amont, licences, archives sources, options de
   compilation, ABI et correctifs ; rapprocher les métadonnées de ces preuves.
3. Construire ou importer le candidat dans un répertoire isolé et comparer
   les différences. Ne pas modifier le verrou pour rendre acceptable un
   fichier dont la provenance n’a pas été expliquée.
4. Après revue, remplacer explicitement l’inventaire, ses modèles et
   `APPROVED_MANIFEST_SHA256` ensemble. Le format est UTF-8 sans BOM, une ligne
   `sha256` minuscule, deux espaces puis un chemin relatif avec `/`, sans
   entrée de répertoire. Conserver une fin de ligne LF.
5. Exécuter les contrôles de politique, un import isolé, les builds Android
   et les validations natives adaptées au changement.

Le SBOM et les notices doivent ensuite décrire les fichiers retenus pour la
diffusion. Les résultats de validation appartiennent à cette diffusion ; ils
ne remplacent pas les entrées et empreintes du verrou courant.
