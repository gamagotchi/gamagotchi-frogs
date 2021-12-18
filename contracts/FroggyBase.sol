// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FroggyAccessControl.sol";

/**
 * @title FroggyBase
 * Facet that manages the frog class.
 */
abstract contract FroggyBase is FroggyAccessControl {

    struct Frog {
        uint256 genes;

        uint64 cooldownEndBlock;

        uint32 matronId;    
        uint32 sireId;

        uint16 generation;
    }

}