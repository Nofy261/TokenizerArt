# Version française — Créer un NFT

## Prérequis

Utiliser Remix et MetaMask sur **BSC Testnet** (Chain ID `97`), avec le compte `creator` et des tBNB pour les frais. Le contrat doit déjà être déployé : voir le [guide de déploiement](../deployment/deployment.md).

## Étapes

1. Dans Remix, charger le contrat `Summer42NFT` déjà déployé à l'adresse :

   ```text
   0x0631a4BB9eC05C6CdBbbC1A650824417074258bC
   ```

2. Consulter `creator()` et sélectionner cette adresse dans MetaMask et Remix.
3. Lire `totalMinted()` avant l'appel et noter sa valeur `N`. Le prochain NFT aura l'identifiant `N + 1`.
4. Appeler **`mint()`**, sans argument, avec **Value à 0**, puis confirmer la transaction dans MetaMask.
5. Attendre la réussite de la transaction et conserver son hash ainsi que l'identifiant du nouveau NFT.

## Vérifications

- `totalMinted()` doit avoir augmenté de `1`.
- `ownerOf(N + 1)` doit retourner l'adresse `creator`.
- `tokenURI(N + 1)` doit retourner le lien IPFS des métadonnées de « summer 42 ».

Remplacer `N + 1` par l'identifiant calculé, par exemple `3` si `N` valait `2`. Pour consulter les métadonnées dans un navigateur, remplacer `ipfs://` par `https://ipfs.io/ipfs/`, puis ouvrir le lien de l'image contenu dans le JSON.

Chaque nouvel appel réussi crée un NFT distinct. Un compte différent de `creator` obtient le refus `Only creator can mint`.

---

# English version — Mint an NFT

## Prerequisites

Use Remix and MetaMask on **BSC Testnet** (Chain ID `97`), with the `creator` account and tBNB to cover fees. The contract must already be deployed: see the [deployment guide](../deployment/deployment.md).

## Steps

1. In Remix, load the existing `Summer42NFT` contract at:

   ```text
   0x0631a4BB9eC05C6CdBbbC1A650824417074258bC
   ```

2. Read `creator()` and select that address in MetaMask and Remix.
3. Read `totalMinted()` before the call and record its value as `N`. The next NFT will have identifier `N + 1`.
4. Call **`mint()`**, with no arguments and **Value set to 0**, then confirm the transaction in MetaMask.
5. Wait for the transaction to succeed and save its hash along with the new NFT's identifier.

## Checks

- `totalMinted()` must have increased by `1`.
- `ownerOf(N + 1)` must return the `creator` address.
- `tokenURI(N + 1)` must return the IPFS metadata link for “summer 42”.

Replace `N + 1` with the calculated identifier, for example `3` if `N` was `2`. To view the metadata in a browser, replace `ipfs://` with `https://ipfs.io/ipfs/`, then open the image link contained in the JSON.

Each new successful call creates a distinct NFT. An account other than `creator` receives the error `Only creator can mint`.
