# Google Play Billing — client Android et contrat attendu

Audit de qualification du 14 octobre 2026 : [Q020](VALIDATION.md#q020), [Q021](VALIDATION.md#q021), [Q022](VALIDATION.md#q022), [Q023](VALIDATION.md#q023), [Q024](VALIDATION.md#q024), [Q029](VALIDATION.md#q029).


Version source **0.2.10+74016**, métadonnées documentaires du **11 octobre 2026**.
Le client natif `BillingClient`, son canal Flutter et les actions d’abonnement
sont intégrés. Package : `com.fuzevpn` ; permission :
`com.android.vending.BILLING` ; bibliothèque : **9.1.0**.

L’accueil et Fuze Premium chargent le catalogue sans session Fuze. Continuer
crée ou reprend un invité après contrôle des achats existants ; l’inscription
reste facultative. Voir [GUEST_ACCOUNTS.md](GUEST_ACCOUNTS.md).

Ce guide décrit les routes et réponses attendues par le code Android. Le
backend, ses migrations, flags, credentials et configuration Pub/Sub ne sont
pas inclus dans ce dépôt. Les reçus API035 et le rapport client 74008
établissent des achats Google de test, acquittements, renouvellements et
observations RTDN datés du 4 octobre ([Q020–Q021](VALIDATION.md#q020)).
Les cycles incomplets et l’essai freetest 74016 ont leurs propres blocages
([Q022–Q023](VALIDATION.md#q022)).

## Catalogue et prix

Les identifiants configurés dans ce client sont fixes. Le serveur compatible
doit les autoriser explicitement :

| Élément | Identifiant |
| --- | --- |
| Package | `com.fuzevpn` |
| Produit abonnement | `premium` |
| Plan mensuel | `monthly` |
| Plan annuel | `yearly` |

Android interroge Google Play `ProductDetails` pour `premium`. Il affiche les
plans disponibles et utilise le jeton d’offre retourné par Play pour le
lancement. Le parcours actuel accepte les plans de base à renouvellement
automatique avec une phase standard, ainsi que l’offre **freetest** composée
de deux semaines gratuites puis de cette phase récurrente. Il affiche toutes
les phases et relit l’offre avant le paiement. Les autres promotions,
prépaiements et versements échelonnés sont écartés. Voir [FREE_TRIAL.md](FREE_TRIAL.md)
et le blocage de recette réelle [Q023](VALIDATION.md#q023).
[Intégration officielle](https://developer.android.com/google/play/billing/integrate).

Le montant affiché est exactement `PricingPhase.formattedPrice`, sans
conversion, recalcul, prix web EUR ou devise codée en dur. La période provient
également de Play : `P1M` pour le mensuel et `P1Y` pour l’annuel. L’interface
n’annonce pas systématiquement « TTC » : le prix formaté exclut la taxe dans
les pays où les prix sont présentés hors taxes. Elle précise : « Prix fourni
par Google Play. Le montant final est confirmé avant le paiement. »
[Référence des phases de prix](https://developer.android.com/reference/com/android/billingclient/api/ProductDetails.PricingPhase).

Le serveur n’a pas à fournir de catalogue de prix Google. Il conserve une
liste autorisée de package, produit et plans, puis vérifie les données chez
Google sans faire confiance aux montants ou durées transmis par Android.
Les captures de revue utilisent des prix de fixtures signalés comme **prix de
test** ; elles ne prouvent pas la disponibilité d’offres Google réelles.

## API commune et authentification

Base : `https://api.fuzevpn.com`. Les routes client privées requièrent
`Authorization: Bearer <access_token>` et des réponses
`Cache-Control: no-store`. Aucun credential Google ni secret serveur n’est
embarqué dans Android. Les jetons d’achat ne doivent jamais apparaître dans les
journaux, diagnostics ou captures de revue.

| Route | Utilisation Android |
| --- | --- |
| `GET /v1/billing/subscription` | Lire le droit FuzeVPN commun, notamment `has_access`, `expires_at`, `provider` et `status`. Cette lecture ne vérifie pas un achat Play. |
| `GET /v1/billing/providers/google-play/purchase-context` | Obtenir la référence opaque du compte et l’autorisation de lancer un achat. |
| `POST /v1/billing/providers/google-play/purchases/verify` | Vérifier ou rapprocher un jeton Play et recevoir le droit commun faisant autorité. |

Les routes web EUR/SumUp, checkout, changement de formule et gestion du
renouvellement web ne gèrent pas un abonnement Google Play. Les factures
FuzeVPN existantes restent accessibles via `GET /v1/billing/invoices` et
`GET /v1/billing/invoices/{id}` ; cet historique est distinct des reçus Google
Play. Le client Android ne crée aucune facture FuzeVPN à partir d’un prix Play.

## Contexte d’achat — contrat client

### `GET /v1/billing/providers/google-play/purchase-context`

Corps vide. Réponse **200** :

```json
{
  "obfuscated_account_id": "<reference_opaque_stable_du_compte>",
  "purchase_allowed": true
}
```

La référence est stable, opaque et non personnelle, propre au compte
FuzeVPN authentifié : de 1 à 64 caractères parmi `A-Z`, `a-z`, `0-9`, `_` et
`-`. Android la transmet à `setObfuscatedAccountId`. Un email ou un identifiant
personnel brut ne convient pas.
[Référence du lien de compte](https://developer.android.com/reference/com/android/billingclient/api/BillingFlowParams.Builder).

`purchase_allowed` est un booléen strict. Un accès web actif ou un abonnement
Play déjà actif bloque un nouvel achat ; restauration et gestion restent
possibles. Le contexte ne renvoie aucun catalogue, montant ou devise et ne
constitue pas une preuve d’achat. Le serveur doit aussi contrôler les conflits
lors de la vérification, y compris ceux survenus après le lancement.

Avant chaque paiement, Android relit le contexte et vérifie la continuité du
compte. Réponse invalide, indisponibilité réseau ou serveur, route introuvable
ou `purchase_allowed: false` empêchent `launchBillingFlow`. Un ancien contexte
en mémoire ne contourne pas cette règle. Le contrôle natif interroge aussi les
achats détenus : un achat `premium` déjà acheté ou pending bloque une seconde
charge. Les prix Play peuvent rester visibles lorsque le contexte API est
indisponible, avec « Abonnements bientôt disponibles » et le bouton de paiement
désactivé.

## Vérification — contrat client

### `POST /v1/billing/providers/google-play/purchases/verify`

Le corps contient **exactement** le jeton fourni par Google Play :

```json
{
  "purchase_token": "<jeton_fourni_par_Play>"
}
```

Android n’ajoute pas `product_id`, de montant, devise, période ou échéance.
Le package, le produit et les plans sont déterminés et vérifiés côté serveur.

Réponse **200**, achat vérifié :

```json
{
  "purchase_status": "verified",
  "subscription": {
    "status": "active",
    "has_access": true,
    "offer_id": "<formule_FuzeVPN_issue_du_plan_verifie>",
    "provider": "google_play",
    "started_at": "<date_UTC_RFC3339>",
    "expires_at": "<date_UTC_RFC3339>",
    "renews_automatically": true,
    "cancel_at_period_end": false
  }
}
```

`subscription` est le même objet commun que celui retourné par
`GET /v1/billing/subscription`. Le client utilise ses droits serveur ; il ne
construit pas de droit à partir d’un callback, d’un achat local ou de son état
« acknowledged ».

| HTTP | `purchase_status` | Signification et comportement Android |
| --- | --- | --- |
| **200** | `verified` | Achat, propriétaire et état validés. Le droit commun retourné fait autorité ; un achat vérifié mais expiré peut avoir `has_access: false`. |
| **200** | `pending` | Paiement en attente chez Google. Aucun nouveau droit Play ni acquittement ; afficher l’attente sans lancer de polling automatique. |
| **202** | `processing` | Vérification ou enregistrement durable en cours. Aucun nouveau droit annoncé par ce statut ; reprendre la vérification de manière bornée au premier plan. |

Les états en attente préservent les droits indépendants éventuels du compte.
Une valeur inconnue, un format invalide ou une combinaison HTTP/statut qui ne
respecte pas ce tableau est une erreur de contrat.

### Propriété, idempotence et acquittement

Le serveur lit l’achat Google pour `com.fuzevpn`, puis contrôle `premium`, le
plan autorisé, l’état, l’échéance et le lien opaque du compte. Il rattache
durablement le jeton à un propriétaire unique avant d’activer le droit.
Revérifier le même jeton pour le même compte est **idempotent**. Un autre
propriétaire est refusé. Un remplacement lié par `linkedPurchaseToken` ne doit
pas accorder deux droits.
[Lecture officielle de l’achat](https://developers.google.com/android-publisher/api-ref/rest/v3/purchases.subscriptionsv2/get).

Après vérification, le serveur persiste durablement le propriétaire du jeton
et le droit vérifié, accorde ce droit, puis acquitte immédiatement le nouvel
achat. Il conserve des reprises durables si l’acquittement échoue. Android
n’acquitte pas l’achat ; une reprise d’acquittement ne signifie ni paiement
refusé ni perte d’un droit vérifié.
Un champ facultatif `acknowledgement_status: "processing"` peut accompagner une
réponse **200** avec `purchase_status: "verified"` lorsque le droit est déjà
durable. Dans ce cas, `subscription.has_access` reste l’autorité et peut valoir
`true` : l’acquittement à reprendre ne transforme pas l’achat vérifié en
`purchase_status: "processing"` ou en paiement pending. Le client ne doit pas
bloquer un droit durable à cause de ce champ facultatif.
[Vérification et sécurité officielles](https://developer.android.com/google/play/billing/security).

### Codes d’erreur attendus

| HTTP | Code | Traitement attendu |
| --- | --- | --- |
| **503** | `google_play_unavailable` | Google est temporairement indisponible ou inaccessible. Aucun nouveau droit ; permettre une reprise explicite. |
| **400** | `google_play_purchase_invalid` | Achat ou jeton invalide. Aucun nouveau droit. |
| **409** | `google_play_account_mismatch` | Le propriétaire ne correspond pas au compte FuzeVPN. Ne pas transférer l’achat. |
| **409** | `google_play_purchase_unsupported` | Produit, plan ou type d’achat non pris en charge. Aucun nouveau droit. |
| **409** | `google_play_test_purchase_not_allowed` | Achat de test interdit par la configuration serveur. Aucun nouveau droit. |

Un refus ou une panne n’efface pas un accès indépendant déjà acquis.

## Reprise Android et cycle de vie

Pour `202 processing`, le contrat client prévoit l’en-tête
**`Retry-After: 5`**, soit un délai de **5 secondes**. Android utilise en priorité
le délai serveur lorsqu’il s’agit d’un nombre de secondes valide compris entre
**1 et 60**. Si l’en-tête est absent ou invalide, les délais locaux de secours
sont **2, 4, 8, 12 et 16 secondes**, selon le rang de la reprise.

Android effectue au maximum **cinq nouvelles tentatives** après la première
réponse. La boucle ne fonctionne qu’au premier plan et pour le même compte.
Elle s’arrête lorsque le statut quitte `processing`, lorsque le budget
est épuisé ou lorsque le contexte de session n’est plus valable. Aucun
polling automatique n’est lancé pour `200 pending`.
Le champ facultatif `acknowledgement_status: "processing"` d’une réponse
`200 verified` ne déclenche pas cette boucle de vérification Android.

Le passage en arrière-plan suspend les relances. Au retour, un achat déjà
en cours de traitement conserve son budget de reprises et attend le délai
prévu ; les callbacks SDK répétés ne contournent pas cette limite. Une déconnexion ou un
changement de compte invalide les opérations, les timers et les réponses en
cours. Une reprise manuelle via « Restaurer les achats » permet de relire les
achats détenus et de les soumettre à nouveau à l’API. Le client ne maintient pas
une boucle sans limite et ne transmet pas un résultat tardif au nouveau compte.

Android rapproche les achats après l’établissement d’une session, lors du
retour au premier plan et à la demande de restauration. La lecture locale
retrouve un achat ; seule la vérification serveur détermine son propriétaire
et les droits. Une restauration ne transfère pas l’abonnement vers un autre
compte FuzeVPN. Un achat pending, processing ou non encore vérifié empêche une
seconde charge jusqu’au rapprochement.

L’invalidation est transmise au client natif, qui vérifie à nouveau le compte
juste avant l’ouverture du paiement. Une feuille Play déjà ouverte conserve
son propriétaire initial. Un retour sans achat libère l’attente pour ce
propriétaire. La sélection Flutter se ferme lors d’un changement de compte.

La gestion ouvre les abonnements Google Play pour `premium` et `com.fuzevpn`.
Au retour, le client relit le droit serveur. Une fermeture de fenêtre ou un
bouton local ne prouve ni paiement ni annulation.

Avant d’ouvrir la procédure de suppression du compte FuzeVPN, l’application
explique que cette suppression n’annule pas le renouvellement Google Play.
Elle propose la gestion Google Play et une continuation explicite vers la
demande de suppression. Cette continuation reste disponible si le fournisseur
est inconnu, si l’API est indisponible ou si le lien Play ne s’ouvre pas.
Sur grand écran, ce dialogue conserve une largeur maximale de **560 dp** ;
son contenu peut défiler pour garder les actions accessibles lorsque le texte
est agrandi.
L’application ne promet ni annulation Google automatique ni remboursement.

| État vérifié chez Google | Droit Play attendu |
| --- | --- |
| Actif ou grace period | Accès jusqu’à l’échéance vérifiée. |
| Renouvellement annulé, période encore valide | Accès jusqu’à l’échéance, renouvellement désactivé. |
| Pending, account hold, pause effective, expiré ou révoqué | Aucun droit Play actif ; préserver les autres droits éventuels. |

[Cycle officiel des abonnements](https://developer.android.com/google/play/billing/lifecycle/subscriptions).

## RTDN et exploitation serveur

La route fournisseur conserve le chemin
`POST /v1/billing/providers/google-play/rtdn`. Elle reçoit les notifications
Pub/Sub push authentifiées, avec l’enveloppe Pub/Sub et son contenu Google
encodé en base64. Elle utilise l’identité de service Google, sans token Bearer
utilisateur FuzeVPN. Valider le JWT, son audience, l’identité attendue et le
package avant de traiter l’événement.
[Authentification Pub/Sub](https://docs.cloud.google.com/pubsub/docs/authenticate-push-subscriptions).

Le reçu API035 documente des RTDN, un acquittement et un renouvellement
réels de test le 4 octobre ([Q021](VALIDATION.md#q021)). La redélivrance,
l’ordre inversé et le cycle exhaustif sont **bloqués faute de preuve dédiée**
([Q022](VALIDATION.md#q022)). Le serveur doit conserver et dédupliquer les
événements, relire Google avant toute modification de droit et supporter les
notifications répétées ou désordonnées. La reprise des acquittements et le
rapprochement des achats doivent fonctionner lorsque l’application est fermée.
Une notification seule ne prouve jamais l’état actuel d’un abonnement.

## Qualification avant activation des ventes

Vérifier l’environnement serveur ciblé : disponibilité du contexte d’achat,
liste des produits/plans autorisés, stratégie empêchant une double
souscription web/Play, validation Google, propriétaire unique, droits durables,
acquittement avec reprise, restauration et rapprochement périodique. Vérifier
les JWT Pub/Sub et le cycle RTDN réel, y compris redélivrance et ordre inversé.

La recette Android doit utiliser un compte Google **testeur de licence** et
un moyen de paiement explicitement indiqué comme test. Un APK installé
localement peut servir aux testeurs de licence si son package correspond à
l’application configurée. Les utilisateurs d’une piste de test qui ne sont
pas testeurs de licence peuvent être facturés.
[Tests Billing officiels](https://developer.android.com/google/play/billing/test).

Matrice de recette ciblée, dont les résultats historiques et les lacunes
sont explicités en [Q020–Q023](VALIDATION.md#q020) : achat
approuvé/refusé/annulé, pending puis finalisation, processing puis reprise
bornée, panne API, restauration sur le même appareil et un nouvel appareil,
changement de compte, renouvellement, annulation, expiration et révocation.
La publication de sources ne livre aucun APK/AAB et ne valide aucune piste Play.
