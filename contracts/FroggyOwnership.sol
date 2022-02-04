// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./FroggyBase.sol";
import "./LilypadOwnership.sol";

/**
 * @title FroggyOwnership
 * Facet that manages ERC721 implementation of frogs
 */
abstract contract FroggyOwnership is FroggyBase, LilypadOwnership {

    uint8 constant maxReleased = 50;

    uint8 totalReleased = 0;

    uint256 nonce = 0;
    Frog[] frogs;

    // TODO: Add URL
    constructor(address _admin, uint256 seedAmount) ERC1155("PLACEHOLDER_URL") { 
        admin = _admin;
        _mintLilypads(seedAmount);
        
        // Dummy / NULL frog
        frogs.push(Frog({
            genes: genes(0, 0, 0, 0, 0, 0),
            parentIds: [uint32(0), uint32(0)],
            generation: 0
        }));
    }

    /// @dev Add a newly bred frog into the 
    function _createFrog(genes memory _genes, uint32 parent1, uint32 parent2, uint16 _generation) internal {
        _mint(msg.sender, ++nonce, 1, "");

        frogs.push(Frog({
            genes: _genes,
            parentIds: [parent1, parent2],
            generation: _generation
        }));
        
    }

    /// @dev Mints a frog. Only available to admin.
    function releaseFrog(genes memory _genes) external onlyAdmin() {
        require(totalReleased < maxReleased, "Cannot release more new frogs");

        _createFrog(_genes, 0, 0, 0);

        totalReleased++;
    }

    /// @dev Get frog metadata by id.
    function getFrog(uint32 frogId) public view returns (Frog memory) {
        require(frogId != 0, "Not a valid frog");
        require(frogId < nonce, "Not a valid frog");

        return frogs[frogId];
    }
}