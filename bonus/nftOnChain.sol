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

    // Je fournis le dessin directement, sans fichier à récupérer sur IPFS.
    function imageURI() public pure returns (string memory) {
        string memory svg = string.concat(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 600">',
            '<defs>',
            '<linearGradient id="sky" x2="0" y2="1">',
            '<stop stop-color="#159ee9"/>',
            '<stop offset="1" stop-color="#8cddff"/>',
            '</linearGradient>',
            '<linearGradient id="sand" x2="0" y2="1">',
            '<stop stop-color="#ffd451"/>',
            '<stop offset="1" stop-color="#f49b16"/>',
            '</linearGradient>',
            '</defs>',
            '<rect width="600" height="600" fill="url(#sky)"/>',
            '<circle cx="465" cy="115" r="65" fill="#ffce32"/>',
            '<rect y="370" width="600" height="230" fill="#078bd3"/>',
            '<path d="M400 410h140 M440 440h110 M380 475h130" ',
            'stroke="#a6e8ff" stroke-width="6" stroke-linecap="round"/>',
            '<path d="M0 365 Q100 320 210 390 T420 460 L0 520Z" ',
            'fill="#ffc339"/>',
            '<path d="M0 450 Q150 390 320 510 T600 530 L600 600 H0Z" ',
            'fill="url(#sand)"/>',
            '<text x="300" y="300" text-anchor="middle" ',
            'font-family="sans-serif" font-size="76" ',
            'font-weight="bold" fill="#fff9df">summer 42</text>',
            '</svg>'
        );

        // Le préfixe précise le format de l'image et son encodage.
        return string.concat(
            "data:image/svg+xml;base64,",
            Base64.encode(bytes(svg))
        );
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        // Je vérifie que le NFT existe.
        _requireOwned(tokenId);

        // Je construis les métadonnées avec l'image intégrée.
        string memory json = string.concat(
            '{"name":"summer 42",',
            '"artist":"nolecler",',
            '"description":"Un paysage d ete avec soleil, mer et collines.",',
            '"image":"', imageURI(), '"}'
        );

        // Je retourne le contenu JSON, sans fichier extérieur.
        return string.concat(
            "data:application/json;base64,",
            Base64.encode(bytes(json))
        );
    }
}
