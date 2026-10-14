# Essai gratuit Google Play — Fuze Premium

Audit de qualification du 14 octobre 2026 : [Q023](VALIDATION.md#q023).


Contrat client du 11 octobre, réconcilié avec les preuves le 14 octobre 2026.
L’audit lit les reçus backend historiques, sans accès serveur live. La recette
freetest réelle est bloquée faute de parcours exécuté : [Q023](VALIDATION.md#q023).

## Configuration retenue

Le produit reste `premium`, avec les forfaits `monthly` et `yearly`. Chacun possède une offre `freetest` : phase gratuite de deux semaines, puis prix récurrent du forfait. L’offre doit être enregistrée **et activée**, dans les régions souhaitées. Le critère confirmé est l’acquisition de nouveaux clients n’ayant jamais eu d’abonnement dans cette application. [Configuration des offres dans Play Console](https://support.google.com/googleplay/android-developer/answer/140504?hl=fr)

Google détermine cette éligibilité à partir de l’historique d’abonnement du compte Google Play. Créer un autre compte FuzeVPN ou un autre invité ne réinitialise pas cet historique. Si le critère devient « Déterminée par le développeur », l’application devra appliquer sa propre règle d’éligibilité ; ce n’est pas la configuration retenue ici. [Critères d’éligibilité](https://support.google.com/googleplay/android-developer/answer/140504?hl=fr)

## Contrat Android

L’application interroge `ProductDetails` pour `premium`. Elle associe chaque offre à son forfait, examine toutes ses phases et transmet le **jeton de l’offre choisie** à `launchBillingFlow`. Les durées, devises et prix proviennent de Google Play. Un résultat trop ancien peut devenir inéligible : le catalogue doit être relu avant l’achat. [Intégration Play Billing](https://developer.android.com/google/play/billing/integrate)

La présentation « 2 semaines d’essai gratuit » correspond uniquement à une offre `freetest` reçue de Play, avec une phase gratuite de 14 jours (`P2W` ou `P14D`), suivie du prix mensuel ou annuel attendu. Sans cette offre validée, l’écran propose l’abonnement normal. Il ne sélectionne aucune formule à la place de l’utilisateur.

Le premier débit affiché avant achat est une **prévision si l’essai commence aujourd’hui**. Google Play confirme l’échéance effective dans sa fenêtre. Les prix formatés peuvent exclure les taxes dans les pays où elles sont ajoutées séparément ; le montant final et les taxes applicables sont confirmés par Google Play. [Phases de tarification](https://developer.android.com/reference/com/android/billingclient/api/ProductDetails.PricingPhase)

## Conséquences côté serveur

Google n’impose pas de nouvelle route FuzeVPN ni d’activation de l’offre dans une base locale. C’est une déduction du fonctionnement de Play Billing : l’offre est configurée dans Play Console et le reçu reste un reçu d’abonnement `premium`. Une éventuelle liste locale de forfaits/offres autorisés devra naturellement accepter les identifiants correspondants ; son existence n’a pas été vérifiée.

Le serveur doit traiter un essai comme un **abonnement actif vérifié**, même si son prix initial est zéro : interroger `purchases.subscriptionsv2.get`, vérifier le produit, le propriétaire, `subscriptionState` et l’échéance du droit. Le champ `offerPhase.freeTrial` décrit la phase d’essai. Le montant seul ne décide pas de l’accès. [Cycle de vie des abonnements](https://developer.android.com/google/play/billing/lifecycle/subscriptions)

Après attribution du droit validé, acquitter le nouvel achat sans attendre le premier paiement : la limite de production est de trois jours. Les achats en attente ne donnent pas accès. Un reçu déjà traité ne doit pas attribuer un deuxième abonnement à un autre propriétaire. [Vérification et acquittement](https://developer.android.com/google/play/billing/security)

Les notifications RTDN déclenchent une relecture de l’état Google et la mise à jour de l’échéance. Renouvellement, annulation, expiration, période de grâce, suspension de paiement et révocation doivent conserver leurs règles de droit respectives. Une annulation de renouvellement n’équivaut pas nécessairement à une expiration immédiate. [Suivi du droit serveur](https://developer.android.com/google/play/billing/lifecycle/subscriptions)

## Textes et recette

La formule affichée précise la durée gratuite, le prix suivant et sa fréquence. Après sélection, l’écran annonce « Aujourd’hui, rien à payer », la date prévue, le renouvellement automatique et l’annulation dans Google Play avant la fin de l’essai. Les conditions et la confidentialité restent accessibles avant validation. Il n’affirme ni gratuité permanente ni absence de paiement ultérieur.

Vérifier les deux forfaits avec : compte Google éligible, compte déjà abonné auparavant, offre indisponible, prix modifié, validation annulée, achat en attente, reprise après mise en arrière-plan et restauration. Le droit serveur doit être utilisable pendant l’essai et refléter l’état Google après chaque transition.

Avec les testeurs de licence, l’essai est accéléré à environ **trois minutes**, puis le mensuel à environ cinq minutes et l’annuel à environ trente minutes. Play Billing Lab peut permettre de réutiliser une offre de test sans recréer des comptes FuzeVPN. La date commerciale estimée avant achat ne remplace pas ces échéances Google de test. [Tests officiels des abonnements](https://developer.android.com/google/play/billing/test)

Les contrôles du client et les prérequis de recette Google/serveur sont
consignés en [Q023](VALIDATION.md#q023) ; les achats historiques 74008
([Q020](VALIDATION.md#q020)) ne sont pas des essais freetest 74016.
