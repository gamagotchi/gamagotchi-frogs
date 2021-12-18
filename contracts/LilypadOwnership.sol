// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @title LilypadOwnership
 * Facet that manages in-game currency, Lilypads.
 */
abstract contract LilypadOwnership is ERC1155 {
    uint8 constant LILYPAD = 0;

    // TODO: implement actual tokenomics
    
    // @dev For testing purposes
    function mintLilypads(uint256 _amount) external {
        _mint(msg.sender, LILYPAD, _amount, "");
    }
}