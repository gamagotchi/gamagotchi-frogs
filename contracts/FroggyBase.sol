// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./FroggyAccessControl.sol";

/**
 * @title FroggyBase
 * Facet that manages the frog class.
 */
abstract contract FroggyBase is FroggyAccessControl {

    struct genes {
        uint16 head;
        uint16 eyes;
        uint16 body;
        uint16 accessory;

        uint8 color;
        uint8 eyeColor;
    }

    struct Frog {
        genes genes;

        uint32[2] parentIds;
        uint16 generation;
    }

}