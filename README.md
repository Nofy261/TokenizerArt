# TokenizerArt — Choix du projet

## Version française

TokenizerArt consiste à créer des NFT associés à une image contenant le nombre 42. Je prépare l'image et ses métadonnées sur IPFS, puis j'utilise un smart contract déployé sur BSC Testnet pour créer les NFT, consulter leurs propriétaires et les transférer. L'œuvre choisie s'intitule **summer 42**.

Un **NFT** (*Non-Fungible Token*, ou **jeton non fongible**) est un élément numérique identifié individuellement, dont le propriétaire et les transferts sont enregistrés sur une blockchain. Il peut être associé à une œuvre, comme une image.

- **BNB Smart Chain Testnet** : je conserve un réseau que je connais déjà et j'utilise des tBNB de test, sans argent réel.
- **Solidity** : j'utilise un langage adapté aux smart contracts de BSC.
- **OpenZeppelin (`ERC721URIStorage`)** : je m'appuie sur une implémentation standard ERC-721 pour gérer la propriété, les transferts et le lien des métadonnées de chaque NFT.
- **Remix et MetaMask** : je conserve des outils déjà utilisés pour compiler, déployer et signer les transactions depuis le navigateur.
- **IPFS via Pinata** : je publie l'image et ses métadonnées avec un stockage distribué. Pinata conserve les fichiers et les partage sans nécessiter que mon ordinateur reste allumé.
- **Mint réservé au déployeur** : je garde une règle d'accès simple, avec une adresse `creator` fixée au déploiement et aucun rôle administratif transférable.
- **Plusieurs créations possibles** : je réutilise le même contrat et j'attribue un identifiant distinct à chaque nouveau NFT grâce à un compteur.
- **NFT attribués au déployeur lors du mint** : je garde une fonction sans paramètre ; les NFT peuvent ensuite être transférés individuellement à d'autres comptes.
- **Même image et mêmes métadonnées pour tous les NFT** : je conserve l'œuvre « summer 42 » pour me concentrer sur la création, la propriété et les transferts des tokens.

---

## English version — Project choices

TokenizerArt consists of creating NFTs associated with an image featuring the number 42. I publish the image and its metadata on IPFS, then use a smart contract deployed on BSC Testnet to mint NFTs, check their owners and transfer them. The chosen artwork is titled **summer 42**.

An **NFT** (*Non-Fungible Token*) is an individually identified digital item whose owner and transfers are recorded on a blockchain. It can be associated with an artwork, such as an image.

- **BNB Smart Chain Testnet**: I keep a network I already know and use test tBNB, without real money.
- **Solidity**: I use a language suited to smart contracts on BSC.
- **OpenZeppelin (`ERC721URIStorage`)**: I rely on a standard ERC-721 implementation to manage ownership, transfers and each NFT's metadata link.
- **Remix and MetaMask**: I keep familiar tools to compile, deploy and sign transactions from the browser.
- **IPFS through Pinata**: I publish the image and its metadata using distributed storage. Pinata stores and shares the files without requiring my computer to stay online.
- **Minting restricted to the deployer**: I keep access control simple, with a `creator` address fixed at deployment and no transferable administrative role.
- **Multiple mints allowed**: I reuse the same contract and assign a distinct identifier to each new NFT using a counter.
- **NFTs assigned to the deployer when minted**: I keep a function with no parameters; NFTs can then be transferred individually to other accounts.
- **Same image and metadata for all NFTs**: I keep the “summer 42” artwork to focus on token creation, ownership and transfers.
