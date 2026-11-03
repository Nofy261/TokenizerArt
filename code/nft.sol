// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Je réutilise OpenZeppelin pour gérer le NFT et son lien vers les métadonnées.
import {ERC721URIStorage, ERC721} from
    "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Summer42NFT is ERC721URIStorage {
    // Je conserve l'adresse qui déploie le contrat et j'interdis sa modification.
    address public immutable creator;

    // Je choisis l'identifiant 1 pour l'unique NFT de ce contrat.
    uint256 public constant TOKEN_ID = 1;

    // Je conserve le lien IPFS des métadonnées, qui contiennent le lien de l'image.
    string private constant METADATA_URI =
        "ipfs://bafkreiajbqd4lji4qvvz4f7kfycfvpyebmdztmnlzoa3j7qlrizx3k4nnu";

    // Je mémorise si le NFT a déjà été créé ; cette valeur vaut false au départ.
    bool public minted;

    // Je définis le nom et le symbole, puis je mémorise l'adresse de déploiement.
    // Je ne crée aucun NFT dans le constructeur.
    constructor() ERC721("summer 42", "SUM42") {
        creator = msg.sender;
    }

    function mint() external {
        // Je réserve la création du NFT à l'adresse qui a déployé le contrat.
        require(msg.sender == creator, "Only creator can mint");

        // Je refuse une nouvelle création si le NFT a déjà été créé.
        require(!minted, "NFT already minted");

        // Je bloque toute nouvelle création avant un éventuel appel au destinataire.
        // Je retrouve la valeur précédente si la transaction échoue ensuite.
        minted = true;

        // Je crée le NFT pour mon adresse de déploiement.
        // Je vérifie aussi la réception si cette adresse est un contrat.
        _safeMint(creator, TOKEN_ID);

        // J'associe le NFT au fichier de métadonnées publié sur IPFS.
        _setTokenURI(TOKEN_ID, METADATA_URI);
    }
}
