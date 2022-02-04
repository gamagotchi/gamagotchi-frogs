// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyBase.sol";
import "./LilypadOwnership.sol";

/**
 * @title FroggyOwnership
 * Facet that manages ERC1155 implementation of frogs
 */
abstract contract FroggyOwnership is FroggyBase, LilypadOwnership {

    uint8 constant maxReleased = 50;

    uint8 totalReleased = 0;

    uint32 nonce = 0;
    Frog[] frogs;

    constructor(address _admin) ERC1155("url for {id}") { 
        admin = _admin;

        // Dummy frog for maintaing index of frogs
        frogs.push(Frog({
            genes: 0,
            cooldownEndBlock: 0,
            matronId: 0,
            sireId: 0,
            generation: 0
        }));
    }

    function _createFrog(uint256 _genes, uint32 _matronId, uint32 _sireId, uint16 _generation) internal {
        _mint(msg.sender, ++nonce, 1, "");

        frogs.push(Frog({
            genes: _genes,
            cooldownEndBlock: 0,
            matronId: _matronId,
            sireId: _sireId,
            generation: _generation
        }));
        
    }

    function releaseFrog(uint256 _genes) external onlyAdmin() {
        require(totalReleased < maxReleased, "Cannot release more new frogs");

        _mint(admin, ++nonce, 1, "");
        
        frogs.push(Frog({
            genes: _genes,
            cooldownEndBlock: 0,
            matronId: 0,
            sireId: 0,
            generation: 0
        }));

        totalReleased++;
    }

    function getFrogsEncoded(address _account) external view returns (bytes memory) {
        bytes memory ownedFrogs = "";
        
        uint16 ptr = 0;
        for (uint32 i = 1; i <= nonce; i++) {
            if (balanceOf(_account, i) == 0) continue;
            
            ownedFrogs = abi.encodePacked(ownedFrogs, i);
            if (ptr >= 4096) break;
        }

        return ownedFrogs;
    }

    function getGenes(uint32 frogId) public view returns (uint256) {
        require(frogId != 0, "Not a valid frog");

        return frogs[frogId].genes;
    }
}