// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./GeneMixerInterface.sol";
import "./GeneComputer.sol";

contract GeneMixer is GeneMixerInterface, GeneComputer {

    uint8 private constant NUM_HEADS = 3;
    uint8 private constant NUM_EYES = 3;
    uint8 private constant NUM_BACKS = 3;
    uint8 private constant NUM_FEET = 0;
    uint8 private constant NUM_MOUTHS = 0;
    uint8 private constant NUM_ABILITIES = 0;

    constructor (address _gameAddress) GeneMixerInterface(_gameAddress) { }

    function mixGenes(uint192 gene1, uint192 gene2) override public view onlyGame() returns (uint192) {

        bytes[48] memory genes;
        for (int i = 0; i < 6; i++) {
            uint8 random = _generateRandom();

            if (random < 35) {
                // Inherit dad's trait

            } else if (random < 70) {
                // Inherit mums's trait

            } else if (random < 75) {
                // Inherit paternal granddad's trait

            } else if (random < 80) {
                // Inherit paternal grandma's trait

            } else if (random < 85) {
                // Inherit maternal grandad's trait
                
            } else if (random < 90) {
                // Inherit maternal grandma's trait

            } else {
                // Randomly mutate
                
            }


        }
    }
}
