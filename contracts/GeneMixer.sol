// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./GeneMixerInterface.sol";

contract GeneMixer is GeneMixerInterface {

    constructor (address _gameAddress) GeneMixerInterface(_gameAddress) { }

    function mixGenes(uint256 gene1, uint256 gene2) override public view onlyGame() returns (uint256) {

    }
}
