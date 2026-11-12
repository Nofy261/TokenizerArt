
# Version française — Documentation de Summer42NFT

## Présentation

Le projet permet de créer et de transférer des NFT associés à **summer 42**, une image représentant un paysage d'été avec le nombre 42.

- **Artiste renseigné dans les métadonnées :** `nolecler`.
- **Réseau :** BNB Smart Chain Testnet — Chain ID `97`.
- **Contrat :** `Summer42NFT`, symbole `SUM42`.
- **Adresse :** `0x0631a4BB9eC05C6CdBbbC1A650824417074258bC`.

## Fonctionnement et règles

```text
NFT sur BSC Testnet → métadonnées JSON sur IPFS → image sur IPFS
```

L'image et les [métadonnées](metadata.json) sont stockées sur IPFS via Pinata. Le contrat enregistre les propriétaires des NFT et leur lien vers les métadonnées.

- Seule l'adresse de déploiement, enregistrée dans `creator`, peut créer des NFT.
- Chaque appel réussi à `mint()` crée un NFT pour cette adresse, avec un nouvel identifiant : `1`, puis `2`, puis `3`, etc.
- Tous les NFT utilisent les mêmes métadonnées et la même image. Ils restent distincts et peuvent être transférés séparément.
- Le propriétaire d'un NFT, ou un compte qu'il a autorisé, peut le transférer. Le déployeur ne conserve aucun droit de transfert particulier après l'avoir cédé.

## Utiliser le contrat dans Remix

Connecter Remix à MetaMask sur **BSC Testnet**, puis charger le contrat déjà déployé à l'adresse indiquée ci-dessus. Pour un nouveau déploiement, suivre le [guide de déploiement](../deployment/deployment.md).

Les opérations de création et de transfert nécessitent une confirmation dans MetaMask et des tBNB pour les frais. Les lectures ci-dessous ne nécessitent pas de transaction.

### Créer un NFT

Depuis le compte `creator`, appeler **`mint()`**, confirmer la transaction, puis attendre sa réussite. Consulter `totalMinted()` pour connaître le nombre de NFT créés.

### Consulter les informations

- **`creator()`** : adresse autorisée à créer des NFT.
- **`totalMinted()`** : nombre total de NFT créés dans ce contrat.
- **`ownerOf(tokenId)`** : propriétaire actuel du NFT demandé.
- **`balanceOf(adresse)`** : nombre de NFT de ce contrat possédés par cette adresse.
- **`tokenURI(tokenId)`** : lien IPFS des métadonnées du NFT demandé.

Pour afficher un lien `ipfs://CID` dans un navigateur, utiliser une passerelle : `https://ipfs.io/ipfs/CID`.

- [Afficher les métadonnées](https://ipfs.io/ipfs/bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu).
- [Afficher l'image](https://ipfs.io/ipfs/bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4).

### Transférer un NFT

Depuis le compte propriétaire, utiliser **`safeTransferFrom(from, to, tokenId)`**, la version à trois paramètres :

- `from` : adresse du propriétaire actuel.
- `to` : adresse du destinataire.
- `tokenId` : identifiant du NFT à transférer.

Confirmer la transaction dans MetaMask. Après sa réussite, `ownerOf(tokenId)` doit retourner le destinataire. Le transfert ne change pas `totalMinted()` ni le lien des métadonnées.

## Tests manuels réalisés dans Remix

Les tests suivants ont été effectués avec `account1`, le déployeur, et `account2`, un autre compte :

- Deux appels à `mint()` par `account1` ont créé les NFT `1` et `2`, attribués à `account1`.
- Les métadonnées et l'image ont été consultées avec succès.
- Un appel à `mint()` par `account2` a été refusé avec `Only creator can mint` ; le compteur est resté à `2`.
- `account1` a transféré le NFT `1` à `account2` : chacun possédait alors un NFT et `totalMinted()` valait toujours `2`.
- `account1` a ensuite tenté de transférer le NFT `1` sans autorisation de `account2` : l'estimation a été refusée avec l'erreur `ERC721InsufficientApproval`. Le NFT est resté à `account2`.

## Bonus — Site de mint

Le [site](../bonus/index.html) utilise ethers.js et MetaMask pour appeler `mint()` sur le contrat mandatory ou le contrat bonus.

Depuis la racine du projet, lancer le serveur local et garder le terminal ouvert :

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Ouvrir [http://localhost:8000/bonus/](http://localhost:8000/bonus/) dans le navigateur avec MetaMask.

1. Sélectionner le compte `creator` et **BSC Testnet** pour la connexion du site dans MetaMask, puis cliquer sur **Connect MetaMask**.
2. Saisir l'adresse du contrat indiquée dans le [guide de déploiement](../deployment/deployment.md), puis cliquer sur **Load contract**.
3. Cliquer sur **Mint NFT**, confirmer dans MetaMask et attendre la réussite. Le site affiche le numéro du NFT créé.

Le site vérifie le réseau et l'adresse du contrat. Le contrat refuse les mints provenant d'un autre compte ; les erreurs sont affichées sur la page. Le PNG en fond du site est un décor : l'image du NFT dépend du contrat chargé. Arrêter le serveur avec **Ctrl + C**.

## Bonus — Métadonnées et image sur la blockchain

Le contrat [Summer42OnChain](../bonus/nftOnChain.sol), déployé à l'adresse `0x08A1107F8cFBB6F6521328797053950FF1D8F6a2` sur **BSC Testnet**, contient un paysage SVG avec le texte « summer 42 » et les informations de l'œuvre. Il fournit les métadonnées et l'image sans utiliser IPFS, avec les mêmes règles de mint que le contrat mandatory.

Pour un NFT existant, `tokenURI(tokenId)` renvoie une chaîne commençant par `data:application/json;base64,`. Décoder la partie après la virgule donne le JSON avec `name`, `artist`, `description` et `image`. Le champ `image` contient le dessin encodé, avec le préfixe `data:image/svg+xml;base64,`.

Pour afficher le dessin dans le navigateur, taper manuellement ce dernier préfixe dans la barre d'adresse, coller immédiatement après la partie Base64 du champ `image`, sans espace ni guillemets, puis appuyer sur Entrée. Pour afficher le NFT dans MetaMask, l'importer sur BSC Testnet avec l'adresse du contrat bonus et son `tokenId`, depuis le compte propriétaire.

---

# English version — Summer42NFT documentation

## Overview

The project allows users to mint and transfer NFTs associated with **summer 42**, an image depicting a summer landscape with the number 42.

- **Artist listed in the metadata:** `nolecler`.
- **Network:** BNB Smart Chain Testnet — Chain ID `97`.
- **Contract:** `Summer42NFT`, symbol `SUM42`.
- **Address:** `0x0631a4BB9eC05C6CdBbbC1A650824417074258bC`.

## How it works and rules

```text
NFT on BSC Testnet → JSON metadata on IPFS → image on IPFS
```

The image and [metadata](metadata.json) are stored on IPFS through Pinata. The contract records NFT owners and their metadata links.

- Only the deployment address, recorded as `creator`, can mint NFTs.
- Each successful call to `mint()` creates an NFT for that address, with a new identifier: `1`, then `2`, then `3`, and so on.
- All NFTs use the same metadata and image. They remain distinct and can be transferred separately.
- An NFT owner, or an account they have authorized, can transfer it. The deployer retains no special transfer rights after transferring it to someone else.

## Using the contract in Remix

Connect Remix to MetaMask on **BSC Testnet**, then load the existing contract at the address above. For a new deployment, follow the [deployment guide](../deployment/deployment.md).

Minting and transfers require confirmation in MetaMask and tBNB to cover fees. The read operations below do not require a transaction.

### Mint an NFT

From the `creator` account, call **`mint()`**, confirm the transaction and wait for it to succeed. Check `totalMinted()` to see how many NFTs have been created.

### Read contract information

- **`creator()`**: address allowed to mint NFTs.
- **`totalMinted()`**: total number of NFTs created by this contract.
- **`ownerOf(tokenId)`**: current owner of the requested NFT.
- **`balanceOf(address)`**: number of NFTs from this contract held by the address.
- **`tokenURI(tokenId)`**: IPFS metadata link for the requested NFT.

To open an `ipfs://CID` link in a browser, use a gateway: `https://ipfs.io/ipfs/CID`.

- [View the metadata](https://ipfs.io/ipfs/bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu).
- [View the image](https://ipfs.io/ipfs/bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4).

### Transfer an NFT

From the owner's account, use **`safeTransferFrom(from, to, tokenId)`**, the version with three parameters:

- `from`: current owner's address.
- `to`: recipient's address.
- `tokenId`: identifier of the NFT to transfer.

Confirm the transaction in MetaMask. Once it succeeds, `ownerOf(tokenId)` must return the recipient. The transfer does not change `totalMinted()` or the metadata link.

## Manual tests performed in Remix

The following tests were performed using `account1`, the deployer, and `account2`, another account:

- Two calls to `mint()` by `account1` created NFTs `1` and `2`, both assigned to `account1`.
- The metadata and image were successfully accessed.
- A call to `mint()` by `account2` was rejected with `Only creator can mint`; the counter remained at `2`.
- `account1` transferred NFT `1` to `account2`: each account then held one NFT, and `totalMinted()` still returned `2`.
- `account1` then attempted to transfer NFT `1` without authorization from `account2`: gas estimation failed with `ERC721InsufficientApproval`. The NFT remained owned by `account2`.

## Bonus — Minting website

The [website](../bonus/index.html) uses ethers.js and MetaMask to call `mint()` on either the mandatory or bonus contract.

From the project root, start the local server and keep the terminal open:

```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

Open [http://localhost:8000/bonus/](http://localhost:8000/bonus/) in the browser with MetaMask.

1. Select the `creator` account and **BSC Testnet** for the website connection in MetaMask, then click **Connect MetaMask**.
2. Enter the contract address listed in the [deployment guide](../deployment/deployment.md), then click **Load contract**.
3. Click **Mint NFT**, confirm in MetaMask and wait for success. The website displays the newly minted NFT's ID.

The website checks the network and contract address. The contract rejects mints from other accounts; errors are displayed on the page. The website's PNG background is decorative: the NFT image depends on the loaded contract. Stop the server with **Ctrl + C**.

## Bonus — On-chain metadata and image

The [Summer42OnChain](../bonus/nftOnChain.sol) contract, deployed at `0x08A1107F8cFBB6F6521328797053950FF1D8F6a2` on **BSC Testnet**, contains an SVG landscape featuring the text "summer 42" and the artwork information. It provides both metadata and image without using IPFS, with the same minting rules as the mandatory contract.

For an existing NFT, `tokenURI(tokenId)` returns a string starting with `data:application/json;base64,`. Decoding the part after the comma gives the JSON containing `name`, `artist`, `description` and `image`. The `image` field contains the encoded drawing, prefixed with `data:image/svg+xml;base64,`.

To display the drawing in the browser, manually type this last prefix in the address bar, paste the Base64 part of the `image` field immediately after it, without spaces or quotation marks, and press Enter. To display the NFT in MetaMask, import it on BSC Testnet using the bonus contract address and its `tokenId`, from the owner's account.
