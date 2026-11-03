// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Je réutilise OpenZeppelin pour gérer le NFT et son lien vers les métadonnées.
import {ERC721URIStorage, ERC721} from
    "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Summer42NFT is ERC721URIStorage {
    // Je conserve l'adresse qui déploie le contrat et j'interdis sa modification.
    address public immutable creator;

    // Je compte les NFT créés ; cette valeur vaut 0 au déploiement.
    uint256 public totalMinted;

    // Je conserve le lien IPFS des métadonnées, qui contiennent le lien de l'image.
    string private constant METADATA_URI =
        "ipfs://bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu";

    // Je définis le nom et le symbole, puis je mémorise l'adresse de déploiement.
    // Je ne crée aucun NFT dans le constructeur.
    constructor() ERC721("summer 42", "SUM42") {
        creator = msg.sender;
    }

    function mint() external {
        // Je réserve la création du NFT à l'adresse qui a déployé le contrat.
        require(msg.sender == creator, "Only creator can mint");

        // Je choisis un nouvel identifiant : 1, puis 2, puis 3, etc.
        uint256 tokenId = totalMinted + 1;

        // Je mémorise cet identifiant avant un éventuel appel au destinataire.
        // Je retrouve la valeur précédente si la transaction échoue ensuite.
        totalMinted = tokenId;

        // Je crée le NFT pour mon adresse de déploiement.
        // Je vérifie aussi la réception si cette adresse est un contrat.
        _safeMint(creator, tokenId);

        // J'associe le NFT au fichier de métadonnées publié sur IPFS.
        _setTokenURI(tokenId, METADATA_URI);
    }
}
