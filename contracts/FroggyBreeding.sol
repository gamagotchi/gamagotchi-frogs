// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyOwnership.sol";
import "./IGeneMixer.sol";

/**
 * @title FroggyOwnership
 * Facet that manages breeding of frogs
 */
contract FroggyBreeding is FroggyOwnership {

    IGeneMixer private geneMixer;

    constructor(
        IGeneMixer _geneMixer, 
        address _admin, 
        uint256 _seedAmount
    ) FroggyOwnership(_admin, _seedAmount) {
        
        geneMixer = _geneMixer;
        
    }

    // Mapping to store breeding prices
    mapping(uint256 => uint256) breedingPrice; // TODO: consider price uint256

    /// @dev Rent frog out for breeding.
    function rentForBreeding(uint32 frogId, uint256 price) external {
        require(frogId != 0, "Invalid frog id");
        require(balanceOf(msg.sender, frogId) > 0, "Frog does not belong to player");

        breedingPrice[frogId] = price;
    }

    /// @dev Borrow frog to breed with another frog owned by breeder.
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

    /// @dev Breed frogs to produce child frog. Parents must be owned by breeder.
    function breed(uint32 parent1, uint32 parent2) external {
        // Ensure frog ids are valid
        require(parent1 != 0 && parent2 != 0, "Invalid frog ids");

        // Ensure breeder has permission to frogs
        require(balanceOf(msg.sender, parent1) > 0 && balanceOf(msg.sender, parent2) > 0, 
            "Frog doesn't belong to breeder"); 
        require(breedingPrice[parent1] == 0 && breedingPrice[parent2] == 0, 
            "Frog is currently being listed for breeding");

        _breed(parent1, parent2);
    }

    /// @dev Internal function to breed frogs to produce child frog. Mint child frog to message sender.
    function _breed(uint32 parent1, uint32 parent2) private {

        genes memory newGenes = geneMixer.mixGenes(frogs[parent1].genes, frogs[parent2].genes);

        uint16 gen = frogs[parent1].generation > frogs[parent2].generation 
            ? frogs[parent1].generation 
            : frogs[parent2].generation;

        gen++;

        _createFrog(newGenes, parent1, parent2, gen);
    }

    /// @dev Before transferring frogs, clear any frog rentals.
    function _beforeTokenTransfer(
        address, address, address, 
        uint256[] calldata ids, uint256[] calldata, bytes calldata
    ) internal override {
    
        for (uint256 i = 0; i < ids.length; i++) {
            breedingPrice[i] = 0;
        }

    }
}
