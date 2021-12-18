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

    constructor(address _admin) ERC1155("url") { 
        _admin = admin;
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
}