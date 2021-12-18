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

    // Mapping to store breeding prices
    mapping(uint256 => uint256) breedingPrice; // TODO: consider price uint256

    function rentForBreeding(uint32 frogId, uint256 price) external {
        require(frogId != 0, "Invalid frog id");
        require(balanceOf(msg.sender, frogId) > 0, "Frog does not belong to player");

        breedingPrice[frogId] = price;
    }

    function borrowForBreeding(uint32 frogId, uint32 borrowedId, address lender) external {
        // Ensure frog ids are valid
        require(frogId != 0 && borrowedId != 0, "Invalid frog ids");

        // Ensure breeder has permission to frog
        require(balanceOf(msg.sender, frogId) > 0, "Frog doesn't belong to breeder"); 
        require(breedingPrice[frogId] == 0, "Own is currently being listed for breeding");

        // Rent frog
        require(balanceOf(lender, borrowedId) > 0, "Lender does not own requested frog");
        require(breedingPrice[borrowedId] > 0, "Requested frog is not listed for breeding");

        safeTransferFrom(msg.sender, lender, LILYPAD, breedingPrice[borrowedId], "");

        _breed(frogId, borrowedId);
        breedingPrice[borrowedId] = 0;
    }

    function breed(uint32 sireId, uint32 matronId) external {
        // Ensure frog ids are valid
        require(sireId != 0 && matronId != 0, "Invalid frog ids");

        // Ensure breeder has permission to frogs
        require(balanceOf(msg.sender, sireId) > 0 && balanceOf(msg.sender, matronId) > 0, "Frog doesn't belong to breeder"); 
        require(breedingPrice[sireId] == 0 && breedingPrice[matronId] == 0, "Frog is currently being listed for breeding");

        _breed(sireId, matronId);
    }

    function _breed(uint32 sireId, uint32 matronId) private {
        uint256 newGenes = geneMixer.mixGenes(frogs[sireId].genes, frogs[matronId].genes);

        uint16 gen = frogs[sireId].generation > frogs[matronId].generation 
                ? frogs[sireId].generation 
                : frogs[matronId].generation;
        gen++;

        _createFrog(newGenes, sireId, matronId, gen);
    }

    // TODO: For transferring frogs, after successful transfer, give any breeding permission to frogs up
}
