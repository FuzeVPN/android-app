# Mention VPN et vidéo pour Google Play

Audit de qualification du 14 octobre 2026 : [Q027](VALIDATION.md#q027), [Q029](VALIDATION.md#q029), [Q032](VALIDATION.md#q032).


## Écran présenté dans l’application

Avant d’activer un tunnel VPN, FuzeVPN présente une mention dédiée intitulée
**Protéger votre connexion**. Elle explique l’utilisation de `VpnService`, le
tunnel chiffré vers les serveurs FuzeVPN et les données nécessaires à la
connexion : trafic Internet des applications, adresses de destination et
requêtes DNS. Le tunnel continue à les acheminer lorsque l’application est en
arrière-plan. L’état, la durée et le volume de données servent à afficher la
connexion dans l’application.

**Accepter et continuer** donne l’accord à cette utilisation. **Pas maintenant**
et le retour ne donnent aucun accord et n’activent pas le VPN. Le lien
**Confidentialité** permet de consulter la politique ; son ouverture ne vaut
pas acceptation. La permission VPN d’Android reste une étape distincte.

Cette mention est séparée des conditions d’utilisation et du consentement aux
diagnostics. Elle est traduite dans les trente langues du client. Sur petit
écran ou avec texte agrandi, le contenu peut défiler et les deux actions
restent accessibles.

## Parcours à filmer

Préparer un appareil de test avec accès VPN actif, sans accord local déjà
accepté pour cette mention et sans permission VPN Android déjà accordée. Une
installation de test neuve convient. Vérifier que le compte peut réellement
se connecter avant de préparer la vidéo ; ne filmer aucun mot de passe ni
reçu d’achat. Ne pas modifier ou effacer une session personnelle pour cela.

Enregistrer une vidéo continue de **90 secondes au maximum** :

1. Ouvrir FuzeVPN depuis son icône, afficher la page de connexion et choisir un
   emplacement.
2. Demander la connexion. Montrer le titre et les trois paragraphes de la
   mention. Si nécessaire, faire défiler lentement jusqu’à ce que tout le texte
   ait été visible.
3. Appuyer sur **Pas maintenant**. Montrer que le VPN reste arrêté.
4. Demander de nouveau la connexion : la même mention réapparaît.
5. Appuyer sur **Accepter et continuer**, puis montrer et accepter la demande
   d’autorisation VPN d’Android.
6. Montrer l’état connecté dans FuzeVPN. Une légende ou une voix peut préciser
   que la connexion utilise le tunnel VPN Android.

Déposer la vidéo sur YouTube en mode **non répertorié**, ou fournir un lien
vers un MP4 accessible sans connexion. Vérifier le lien dans une fenêtre
privée avant de le transmettre à Play Console. L’acceptation de la déclaration
reste une décision de Google.

Les exigences de parcours, de refus/reprise et de lecture intégrale sont
précisées dans [la documentation Google sur VpnService](https://support.google.com/googleplay/android-developer/answer/12564964).
La mention et l’accord doivent précéder l’accès concerné, conformément à
[la politique Google sur les données utilisateur](https://support.google.com/googleplay/android-developer/answer/10144311#personal-sensitive).

## Périmètre vérifiable

Ce guide décrit la mention et les traitements du **client Android**. Le dépôt
n’inclut pas le backend ni l’infrastructure VPN. Il ne qualifie pas les journaux,
la conservation, les éventuels destinataires tiers ou les pratiques des serveurs.
Il ne prétend pas que le service est « sans journaux » ni que les données
transmises sont anonymes.

La politique de confidentialité et la déclaration de sécurité des données
Play Console doivent décrire les traitements réellement effectués par le
service complet. Un changement des traitements doit être reflété dans ces
documents et, lorsque nécessaire, dans la mention et la déclaration VpnService.
Les tests de l’écran et de son refus ne constituent pas une recette réseau ou
un audit des serveurs.
