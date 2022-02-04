// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyBase.sol";

abstract contract IGeneMixer is FroggyBase {

    address public gameAddress;

    constructor (address _admin) FroggyBase() { }

    /// @dev Modifer for functions only accessible to the game.
    modifier onlyGame() {
        require(msg.sender == gameAddress);
        _;
    }

    function mixGenes(genes calldata gene1, genes calldata gene2) virtual public view returns (genes memory);
}
