
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
