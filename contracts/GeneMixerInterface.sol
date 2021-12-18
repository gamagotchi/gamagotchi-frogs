// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract GeneMixerInterface {

    address public gameAddress;

    constructor (address _gameAddress){
        gameAddress = _gameAddress;
    }

    /// @dev Modifer for functions only accessible to the game.
    modifier onlyGame() {
        require(msg.sender == gameAddress);
        _;
    }

    function mixGenes(uint256 gene1, uint256 gene2) virtual public view returns (uint256);
}