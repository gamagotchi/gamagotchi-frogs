// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @title LilypadOwnership
 * Facet that manages in-game currency, Lilypads.
 */
abstract contract LilypadOwnership is ERC1155 {
    uint8 constant LILYPAD = 0;

    /// @dev Mint Lilypads
    function _mintLilypads(uint256 _amount) internal {
        _mint(msg.sender, LILYPAD, _amount, "");
    }
}