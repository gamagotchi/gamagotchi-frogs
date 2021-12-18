// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyOwnership.sol";
import "./GeneMixerInterface.sol";

/**
 * @title FroggyOwnership
 * Facet that manages breeding of frogs
 */
abstract contract FroggyBreeding is FroggyOwnership {

    GeneMixerInterface private geneMixer;

    constructor(GeneMixerInterface _geneMixer, address _admin) FroggyOwnership(_admin) {
        geneMixer = _geneMixer;
    }

    // Mapping to store whether breeding is approved
    mapping(uint256 => mapping(address => bool)) breedingPermission;

    function rentForBreeding(uint256 frogId, uint256 price) external {
        
    }

    function borrowForBreeding(uint256 frogId) external {

    }

    function breed(uint256 sireId, uint256 matronId) external {

        // Ensure frog ids are valid
        require(sireId != 0 && matronId != 0 
                && sireId <= nonce && matronId <= nonce, "Invalid frog ids");

        // Ensure breeder has permission to frogs
        require(balanceOf(msg.sender, sireId) > 0);
        require(balanceOf(msg.sender, matronId) > 0 || breedingPermission[matronId][msg.sender]);

        uint256 newGenes = geneMixer.mixGenes(frogs[sireId].genes, frogs[matronId].genes);

        uint32 gen = frogs[sireId].generation > frogs[matronId].generation 
                ? frogs[sireId].generation 
                : frogs[matronId].generation;
        gen++;

        _createFrog(newGenes, gen, sireId, matronId, gen);
    }

    // TODO: For transferring frogs, after successful transfer, give any breeding permission to frogs up

}