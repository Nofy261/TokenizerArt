# TokenizerArt — Notes de travail

Notes de la session du **3 novembre 2026**, à réorganiser pour le README final.

**État actuel :** l'image et les métadonnées sont publiées sur IPFS via Pinata. Le contrat est écrit et sa compilation locale a été vérifiée. Le déploiement, le mint et les tests de transactions restent à faire.

## Objectif du projet

Je crée un NFT associé à une image contenant le nombre 42. Je dois comprendre et pouvoir expliquer toute la chaîne :

```text
Créer l'image
    → la publier sur IPFS
    → préparer et publier ses métadonnées
    → écrire le contrat
    → compiler et déployer le contrat sur une blockchain de test
    → appeler mint pour créer le NFT
    → vérifier le propriétaire, les métadonnées et l'affichage de l'image
```

Je conserve BNB Smart Chain Testnet, Remix et MetaMask, que je connais déjà, pour me concentrer sur les NFT, leurs métadonnées et IPFS.

## Exigences du sujet et choix personnels

### Partie obligatoire du sujet

- Créer une image contenant le nombre **42 correctement représenté**, sans termes ni images insultants.
- Stocker cette image avec une technologie distribuée, comme IPFS.
- Respecter le standard NFT de la blockchain choisie. Pour BSC, le sujet cite BEP-721.
- Gérer les métadonnées : le nom de l'artiste doit être mon login et le nom de l'œuvre doit comprendre 42 et un titre.
- Écrire un code commenté, avec des noms de variables et de fonctions explicites, dans `code/` à la racine.
- Prendre en compte la propriété et les permissions, et pouvoir démontrer le fonctionnement avec des actions simples.
- Déployer le contrat et créer le NFT sur une blockchain publique de test, sans argent réel.
- Pouvoir afficher le NFT et vérifier son propriétaire, par exemple avec `ownerOf`.
- Indiquer l'adresse publique du contrat et le réseau utilisé dans le dépôt.
- Fournir les fichiers nécessaires au déploiement dans un dossier séparé, dont le nom est libre.
- Expliquer mes choix et leurs raisons dans le `README.md` à la racine.
- Fournir une documentation claire dans `documentation/`, expliquant ce que représente le NFT et comment utiliser le projet.
- Comprendre le code et pouvoir l'expliquer pendant la revue de code de l'évaluation.

### Mes choix pour rester simple

- Réseau : **BNB Smart Chain Testnet**, que je connais déjà.
- Langage : **Solidity**.
- Compilation et interaction : **Remix IDE**.
- Signature des transactions : **MetaMask**.
- Stockage : **IPFS via Pinata**, espace public et offre gratuite.
- Contrat : implémentation ERC-721 d'OpenZeppelin avec `ERC721URIStorage`.
- Un seul NFT au maximum dans ce contrat.
- Seule l'adresse qui déploie le contrat peut appeler `mint`.
- Le mint attribue le NFT à cette adresse.
- Aucun NFT créé dans le constructeur : le mint est une transaction séparée du déploiement.
- Les imports OpenZeppelin ne fixent pas de version, selon mon choix.

Le sujet n'impose pas cette limite d'un NFT, cette politique de mint, Pinata, Remix ou BSC Testnet. Ce sont mes choix de conception et d'outillage.

## Organisation du dépôt

```text
TokenizerArt/
├── README.md
├── AGENT.md
├── note.txt
├── code/
│   └── nft.sol
├── deployment/
├── mint/
└── documentation/
    ├── doc.md
    ├── metadata.json
    └── summer-42.png
```

- `code/` : code du contrat.
- `deployment/` : fichiers et informations de déploiement, à compléter.
- `mint/` : fichiers et informations concernant la création du NFT, à compléter.
- `documentation/` : documentation et, pour le moment, fichiers de l'œuvre et de ses métadonnées.
- `note.txt` : notes personnelles prises pendant l'apprentissage.
- `AGENT.md` : consignes d'accompagnement pédagogique.

`code/`, `documentation/` et le `README.md` à la racine sont explicitement demandés. `deployment/` et `mint/` figurent dans l'arborescence d'exemple du sujet ; le nom du dossier de déploiement est libre.

Le sujet ne précise pas où ranger localement l'image. Je la conserve dans `documentation/`.

## Notions comprises : token, NFT et image

Un NFT est un type de token : un **token non fongible**.

Mon NFT est identifié individuellement par son `tokenId`, fixé à `1` dans ce contrat. Il n'est pas découpé en unités décimales.

Le `tokenId` est unique dans un contrat, pas dans toutes les blockchains. Pour identifier précisément un NFT, il faut le réseau, l'adresse du contrat et son `tokenId`.

- **L'image** est le fichier de l'œuvre.
- **Les métadonnées** sont sa fiche descriptive et contiennent le lien de l'image.
- **Le NFT** est le token distinct dont le contrat enregistre le propriétaire et permet de retrouver les métadonnées.
- **Le contrat** est le programme qui applique les règles de création, de propriété et de transfert.
- **La blockchain** conserve le contrat et son état, notamment les propriétaires des tokens.

L'analogie du certificat numéroté aide à comprendre le NFT, mais le fichier image peut être copié. Copier ou télécharger l'image ne transfère pas le NFT.

## Mon œuvre : summer 42

- Titre : **summer 42**.
- Artiste indiqué dans les métadonnées : **nolecler**, mon login 42.
- Description : un paysage d'été avec du soleil, la mer et des collines dorées.
- Le texte « summer 42 » est visible dans l'image.
- Fichier local : [documentation/summer-42.png](documentation/summer-42.png).
- L'image a été générée avec l'outil intégré `image_gen`.

Le sujet n'impose ni format ni dimensions précis. Le fichier retenu est un PNG.

## IPFS, Pinata, CID et passerelle

La phrase simple pour présenter mon choix est :

> Mon image est stockée sur IPFS via Pinata.

Concrètement :

- Je conserve le fichier original sur mon ordinateur.
- Pinata conserve une copie sur ses machines et la partage sur le réseau IPFS.
- IPFS est un réseau et un ensemble de règles pour retrouver et échanger des fichiers ; ce n'est pas une entreprise qui stocke tous les fichiers dans un endroit unique.
- Pinata a effectué l'ajout à IPFS pour moi lorsque j'ai envoyé le fichier dans son espace public.
- Le **pinning** consiste à conserver les données sur un nœud IPFS, en les protégeant du nettoyage automatique du stockage.
- La disponibilité ne nécessite pas que mon ordinateur reste allumé, puisque Pinata fournit le fichier. Elle dépend toutefois du maintien de copies disponibles, notamment de celle conservée par Pinata.

Le **CID**, ou Content Identifier, identifie le contenu dans IPFS. Il dépend du contenu et de sa représentation dans IPFS, pas de mon compte Pinata. Un autre nœud peut conserver et fournir le contenu identifié par ce même CID.

Deux formes de liens sont utiles :

```text
ipfs://CID                  → référence IPFS, utilisée dans le NFT et les métadonnées
https://ipfs.io/ipfs/CID     → accès par une passerelle depuis un navigateur
```

Un navigateur peut ne pas prendre directement en charge `ipfs://`. La passerelle sert d'intermédiaire : elle permet au navigateur d'obtenir le contenu identifié par le CID depuis IPFS, éventuellement à partir d'une copie en cache.

Ouvrir le lien HTTPS vérifie que le fichier est accessible par cette passerelle à ce moment-là. Le navigateur affiche le fichier ; il n'est pas notre service de stockage.

Je n'ai pas à supprimer la copie locale après l'envoi. Le sujet demande un stockage distribué, mais pas un stockage exclusivement sur IPFS.

### Références de l'image

CID :

```text
bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4
```

Lien IPFS utilisé dans les métadonnées :

```text
ipfs://bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4
```

[Afficher l'image via une passerelle](https://ipfs.io/ipfs/bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4).

### Références des métadonnées

CID :

```text
bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu
```

Lien IPFS utilisé dans le contrat :

```text
ipfs://bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu
```

[Afficher les métadonnées via une passerelle](https://ipfs.io/ipfs/bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu).

J'ai vérifié dans mon navigateur que l'image et le JSON s'affichent via la passerelle.

## Métadonnées

Le fichier [documentation/metadata.json](documentation/metadata.json) contient :

```json
{
  "name": "summer 42",
  "description": "Un paysage d'été avec du soleil, la mer et des collines dorées.",
  "artist": "nolecler",
  "image": "ipfs://bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4"
}
```

JSON est un format de données : chaque champ associe un nom à une valeur. Le champ `artist` est notre champ descriptif pour renseigner le login exigé par le sujet.

`doc.md` regroupe les explications destinées aux lecteurs. `metadata.json` est un fichier distinct destiné aux applications qui afficheront le NFT.

L'image et les métadonnées sont deux fichiers distincts, avec deux CID différents. J'ai publié l'image d'abord pour pouvoir inclure son lien dans les métadonnées, puis j'ai publié les métadonnées.

```text
BSC Testnet
└── Contrat Summer42NFT, identifié par son adresse future
    └── NFT identifié par son tokenId = 1, après le mint
        ├── Propriétaire : consultable avec ownerOf(1)
        └── tokenURI(1) → lien IPFS de metadata.json
                              ├── name : summer 42
                              ├── description
                              ├── artist : nolecler
                              └── image → lien IPFS de summer-42.png
```

Les métadonnées contiennent un lien vers l'image, pas le fichier image lui-même. Le contrat conserve un lien vers les métadonnées ; il ne téléverse pas les fichiers sur IPFS.

## Contrat retenu et fonctionnement

- Fichier : [code/nft.sol](code/nft.sol).
- Nom du contrat : `Summer42NFT`.
- Nom retourné par `name()` : `summer 42`.
- Symbole retourné par `symbol()` : `SUM42`.
- Pragma Solidity : `^0.8.24`.
- Dépendance : `ERC721URIStorage` d'OpenZeppelin, sans version fixée dans l'import.
- Identifiant du NFT : `1`.

`ERC721URIStorage` apporte les fonctions standard, dont `ownerOf`, `balanceOf`, les transferts et la consultation du lien des métadonnées. Notre code ajoute les règles de mint.

### Variables et constructeur

- `creator` : adresse qui déploie le contrat. Elle est `immutable`, donc fixée au déploiement et ensuite non modifiable.
- `TOKEN_ID` : constante égale à `1`.
- `METADATA_URI` : constante contenant le lien IPFS des métadonnées.
- `minted` : booléen initialement égal à `false`, qui mémorise si le NFT a été créé.
- `constructor()` : définit le nom et le symbole, puis enregistre `msg.sender` dans `creator`. Il ne crée pas de NFT.
- `msg.sender` : adresse qui appelle le contrat ; dans notre déploiement direct depuis Remix et MetaMask, il s'agit du compte de déploiement.

### Fonction mint

`mint()` est une fonction externe sans paramètre. Le destinataire, le tokenId et le lien des métadonnées sont définis dans le code.

```text
Vérifier que l'appelant est creator
    → vérifier que minted vaut false
    → passer minted à true
    → créer le NFT numéro 1 pour creator avec _safeMint
    → associer le lien des métadonnées avec _setTokenURI
```

- Un `require` refuse la transaction si sa condition n'est pas satisfaite.
- `minted` passe à `true` avant `_safeMint` pour empêcher une nouvelle création pendant un éventuel appel au destinataire.
- `_safeMint` crée le NFT et vérifie la capacité de réception si le destinataire est un contrat.
- `_setTokenURI` associe le NFT au lien des métadonnées déjà publiées ; il n'envoie aucun fichier sur IPFS.
- Si une étape échoue, les modifications de la transaction sont annulées, y compris le changement de `minted`.

Résultat attendu :

```text
Déploiement réussi → contrat présent, aucun NFT
Premier mint réussi → NFT numéro 1 attribué à creator
Nouvel appel à mint → refus
Appel par une autre adresse → refus
```

### Créateur du contrat et propriétaire du NFT

`creator` est l'adresse autorisée à créer le NFT. `ownerOf(1)` indique le propriétaire actuel du NFT.

Ces deux adresses seront identiques juste après le mint. Si le NFT est transféré, `ownerOf(1)` changera et `creator` restera inchangé. Le rôle de créateur ne peut pas être transféré dans ce contrat.

## Compilation et déploiement : ce qui reste à faire

Le déroulement prévu est :

1. Comprendre et réécrire le contrat avec mes propres explications.
2. Compiler le fichier dans Remix et relever le compilateur et les paramètres réellement utilisés.
3. Connecter Remix à MetaMask avec **BSC Testnet** sélectionné.
4. Vérifier que le compte dispose de tBNB de test pour les frais.
5. Cliquer sur Deploy dans Remix : Remix prépare la transaction.
6. Vérifier et confirmer la transaction dans MetaMask : le wallet la signe et l'envoie.
7. Attendre la validation du réseau et conserver l'adresse du contrat.
8. Retrouver le contrat dans « Deployed Contracts » dans Remix.
9. Appeler `mint` avec le même compte et confirmer cette deuxième transaction dans MetaMask.
10. Vérifier le résultat et les permissions.

La compilation locale ne nécessite pas de transaction. Le déploiement et le mint sont deux transactions distinctes, avec des frais payés en tBNB de test, sans argent réel.

L'appel externe à `mint` sur BSC Testnet nécessite que le contrat soit déjà déployé et accessible à une adresse.

## Vérifications à effectuer après le déploiement

- Avant le mint : `minted()` doit retourner `false` et `balanceOf(creator)` doit retourner `0`.
- Avant le mint : `ownerOf(1)` et `tokenURI(1)` doivent refuser la consultation d'un token qui n'existe pas encore.
- Avec un autre compte : `mint()` doit être refusé, sans créer de NFT.
- Avec le compte de déploiement : le premier `mint()` doit réussir.
- Après le mint : `minted()` doit retourner `true` et `balanceOf(creator)` doit retourner `1`, tant que le NFT n'a pas été transféré.
- `ownerOf(1)` doit retourner l'adresse de déploiement juste après la création.
- `tokenURI(1)` doit retourner le lien IPFS des métadonnées indiqué plus haut.
- Les métadonnées doivent renvoyer vers l'image « summer 42 », qui doit s'afficher.
- Un deuxième appel à `mint()` doit être refusé.
- Le transfert du NFT et les permissions de transfert seront également à vérifier pour démontrer son fonctionnement.

La vérification de propriété porte sur le NFT. Le contrat enregistre la possession du token associé à l'image, pas la possession de toutes les copies du fichier image.

## Informations à compléter après les transactions

| Information | Valeur actuelle |
| --- | --- |
| Réseau prévu | BNB Smart Chain Testnet |
| Adresse du contrat | À renseigner après déploiement |
| Adresse du compte de déploiement | À renseigner |
| Transaction de déploiement | À renseigner |
| Transaction de mint | À renseigner |
| TokenId prévu | `1` |
| Propriétaire après mint | À vérifier avec `ownerOf(1)` |
| Compilateur et paramètres utilisés dans Remix | À renseigner |

## Avancement de la partie obligatoire

- [x] Lire le sujet et définir une approche simple.
- [x] Créer l'image contenant 42.
- [x] Publier l'image sur IPFS via Pinata et conserver son CID.
- [x] Préparer un fichier JSON avec le titre, le login et le lien de l'image.
- [x] Publier les métadonnées sur IPFS et conserver leur CID.
- [x] Vérifier l'affichage de l'image et du JSON dans le navigateur.
- [x] Écrire un premier contrat commenté et vérifier sa compilation locale.
- [ ] Comprendre et réécrire le contrat progressivement.
- [ ] Compiler et relever les paramètres dans Remix.
- [ ] Déployer sur BSC Testnet.
- [ ] Appeler `mint` pour créer le NFT.
- [ ] Vérifier propriété, métadonnées, affichage, refus des appels non autorisés et transferts.
- [ ] Compléter les fichiers et informations de déploiement et de mint.
- [ ] Inscrire l'adresse du contrat et le réseau dans le dépôt.
- [ ] Réorganiser ce README et terminer `documentation/`.
- [ ] Préparer une démonstration simple et pouvoir expliquer le code et les choix.

La partie obligatoire ne sera terminée qu'après vérification du fonctionnement et des livrables. Le déploiement et le mint seuls ne remplacent pas la documentation.

## Bonus : à garder pour plus tard

Le sujet propose une œuvre visuellement soignée, un site permettant le mint avec une interface graphique et le stockage des métadonnées et de l'image directement sur la blockchain (« NFT Inscriptions »).

Les bonus ne sont évalués que si toute la partie obligatoire est complète et fonctionne parfaitement. La vidéo de démonstration est facultative et ne rapporte pas de points supplémentaires.

## Reprise de la prochaine session

**Reprendre la lecture et la réécriture de `code/nft.sol`, expliquer chaque partie, puis préparer la compilation dans Remix.** Ne pas considérer le NFT comme déjà créé : seul le contrat source est prêt pour le moment.

L'objectif reste de comprendre et de savoir présenter le projet, en privilégiant un accompagnement progressif conformément à `AGENT.md`.

## Références utiles

- Sujet fourni : `TokenizerArt.pdf`, version 1.00.
- [OpenZeppelin : ERC-721](https://docs.openzeppelin.com/contracts/5.x/erc721).
- [IPFS : publication et pinning d'un fichier](https://docs.ipfs.tech/quickstart/pin/).
- [IPFS : conservation et disponibilité des données](https://docs.ipfs.tech/concepts/persistence/).
- [Remix : import des dépendances](https://remix-ide.readthedocs.io/en/latest/import.html).
