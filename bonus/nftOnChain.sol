// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract Summer42OnChain is ERC721 {
    address public immutable creator;
    uint256 public totalMinted;

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
    }

    function tokenURI(uint256 tokenId)
        public view override
        returns (string memory)
    {
        // Je vérifie que le NFT existe.
        _requireOwned(tokenId);

        // Les métadonnées sont intégrées ; seule l'image reste sur IPFS.
        string memory json = string.concat(
            '{"name":"summer 42",',
            '"artist":"nolecler",',
            '"description":"Un paysage d ete avec soleil, mer et collines.",',
            '"image":"ipfs://bafybeighjfynytzxkka47r2654lbubwdea4ohf2ym2jxo23wd4hcbrvyq4"}'
        );

        // Je retourne la fiche JSON directement, encodée en Base64.
        return string.concat(
            "data:application/json;base64,",
            Base64.encode(bytes(json))
        );
    }
}
