// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyBase.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @title FroggyOwnership
 * Facet that manages ERC1155 implementation of frogs
 */
abstract contract FroggyOwnership is FroggyBase, ERC1155 {

    uint32 nonce = 0;
    Frog[] frogs;

    constructor(address _admin) ERC1155("url") { 
        _admin = admin;
    }
    
    function _createFrog(uint256 _genes, uint32 _matronId, uint32 _sireId, uint16 _generation) internal {
        _mint(msg.sender, ++nonce, 1, "");

        frogs.push(Frog({
            genes: _genes,
            matronId: _matronId,
            sireId: _sireId,
            generation: _generation
        }));
        
    }

    function createFrog()
}