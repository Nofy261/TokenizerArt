# Version française — Déployer le contrat Summer42NFT

Ce guide explique comment déployer une nouvelle instance du contrat sur **BNB Smart Chain Testnet**, avec Remix et MetaMask.

## Prérequis

- MetaMask installé et connecté à **BSC Testnet** : identifiant du réseau **97**, monnaie **tBNB**.
- Un compte disposant de tBNB de test pour payer les frais de déploiement.
- Le fichier [code/nft.sol](../code/nft.sol) du projet.

## 1. Compiler dans Remix

1. Ouvrir [Remix IDE](https://app.remix.live), puis importer ou copier le fichier `nft.sol`.
2. Dans **Solidity Compiler**, choisir une version compatible avec `pragma solidity ^0.8.24` et les imports OpenZeppelin. Remix récupère les dépendances lors de la compilation.
3. Choisir une cible EVM compatible avec BSC Testnet. Noter la version du compilateur, la cible EVM et les paramètres d'optimisation utilisés.
4. Cliquer sur **Compile nft.sol** et vérifier qu'aucune erreur de compilation ne subsiste.

## 2. Déployer avec MetaMask

1. Ouvrir **Deploy & Run Transactions** et sélectionner l'environnement connecté à MetaMask (**Browser Extension**, puis MetaMask).
2. Vérifier que le réseau est **BSC Testnet** et que le compte sélectionné est celui qui doit devenir `creator`.
3. Sélectionner le contrat **Summer42NFT**. Le constructeur ne demande aucun argument ; laisser **Value à 0**. Les frais de gas sont payés séparément en tBNB.
4. Cliquer sur **Deploy**, puis confirmer la transaction dans MetaMask.
5. Attendre sa réussite. Le contrat apparaît dans **Deployed Contracts** avec sa propre adresse.

Conserver l'adresse du contrat et le hash de la transaction de déploiement.

## 3. Vérifier le nouveau contrat

- `creator()` doit retourner l'adresse du compte qui l'a déployé.
- `totalMinted()` doit retourner `0` immédiatement après ce nouveau déploiement, avant tout mint.

Le déploiement installe le programme sur la blockchain. La création des NFT se fait ensuite par des appels séparés à `mint()`, depuis le compte `creator`.

## Contrat mandatory déjà déployé

- **Réseau :** BNB Smart Chain Testnet — Chain ID `97`.
- **Contrat :** `Summer42NFT`.
- **Adresse :** `0x0631a4BB9eC05C6CdBbbC1A650824417074258bC`.
- **Adresse du déployeur :** `0x30E60e59368fe5bFB6AED7431980ed6366543b4d`.

[Consulter le contrat sur BscScan Testnet](https://testnet.bscscan.com/address/0x0631a4BB9eC05C6CdBbbC1A650824417074258bC).

## Contrat bonus déjà déployé

- **Contrat :** `Summer42OnChain` — [source](../bonus/nftOnChain.sol).
- **Réseau :** BNB Smart Chain Testnet — Chain ID `97`.
- **Adresse :** `0xb32924c0476151Db5684998D5b3097f5f32FA7FD`.
- **Déployeur :** `0x30E60e59368fe5bFB6AED7431980ed6366543b4d`.
- **Déploiement :** 11 novembre 2026.

Cette instance fournit les métadonnées directement via `tokenURI()` ; l'image reste sur IPFS. Elle est distincte du contrat mandatory et possède son propre compteur et ses propres NFT. Pour la redéployer, suivre les étapes ci-dessus avec le fichier bonus et sélectionner `Summer42OnChain`.

[Consulter le contrat bonus sur BscScan Testnet](https://testnet.bscscan.com/address/0xb32924c0476151Db5684998D5b3097f5f32FA7FD).

---

# English version — Deploying the Summer42NFT contract

This guide explains how to deploy a new instance of the contract on **BNB Smart Chain Testnet**, using Remix and MetaMask.

## Prerequisites

- MetaMask installed and connected to **BSC Testnet**: chain ID **97**, currency **tBNB**.
- An account holding test tBNB to cover deployment fees.
- The project's [code/nft.sol](../code/nft.sol) file.

## 1. Compile in Remix

1. Open [Remix IDE](https://app.remix.live), then import or copy the `nft.sol` file.
2. In **Solidity Compiler**, select a version compatible with `pragma solidity ^0.8.24` and the OpenZeppelin imports. Remix fetches dependencies during compilation.
3. Select an EVM target compatible with BSC Testnet. Record the compiler version, EVM target and optimization settings used.
4. Click **Compile nft.sol** and make sure there are no remaining compilation errors.

## 2. Deploy with MetaMask

1. Open **Deploy & Run Transactions** and select the environment connected to MetaMask (**Browser Extension**, then MetaMask).
2. Check that the network is **BSC Testnet** and that the selected account is the one that should become `creator`.
3. Select the **Summer42NFT** contract. The constructor takes no arguments; leave **Value at 0**. Gas fees are paid separately in tBNB.
4. Click **Deploy**, then confirm the transaction in MetaMask.
5. Wait for the transaction to succeed. The contract appears under **Deployed Contracts** with its own address.

Save the contract address and the deployment transaction hash.

## 3. Check the new contract

- `creator()` must return the address of the account that deployed it.
- `totalMinted()` must return `0` immediately after this new deployment, before any mint.

Deployment installs the program on the blockchain. NFTs are then created through separate calls to `mint()`, made by the `creator` account.

## Existing mandatory deployment

- **Network:** BNB Smart Chain Testnet — Chain ID `97`.
- **Contract:** `Summer42NFT`.
- **Address:** `0x0631a4BB9eC05C6CdBbbC1A650824417074258bC`.
- **Deployer address:** `0x30E60e59368fe5bFB6AED7431980ed6366543b4d`.

[View the contract on BscScan Testnet](https://testnet.bscscan.com/address/0x0631a4BB9eC05C6CdBbbC1A650824417074258bC).

## Existing bonus deployment

- **Contract:** `Summer42OnChain` — [source](../bonus/nftOnChain.sol).
- **Network:** BNB Smart Chain Testnet — Chain ID `97`.
- **Address:** `0xb32924c0476151Db5684998D5b3097f5f32FA7FD`.
- **Deployer:** `0x30E60e59368fe5bFB6AED7431980ed6366543b4d`.
- **Deployment date:** November 11, 2026.

This instance provides metadata directly through `tokenURI()`; the image remains on IPFS. It is separate from the mandatory contract and has its own counter and NFTs. To redeploy it, follow the steps above using the bonus file and select `Summer42OnChain`.

[View the bonus contract on BscScan Testnet](https://testnet.bscscan.com/address/0xb32924c0476151Db5684998D5b3097f5f32FA7FD).
