// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract GeneComputer {

    uint192 private constant KEY_MASK = uint192(0x10B100101); // Encryption Key: keccak256(KEY_MASK & genes or KEY_MASK & traits)

    function _encrypt(uint192 traits) internal pure returns (uint192) {
        uint192 key = KEY_MASK & traits;
        uint192 rawTraits = traits ^ uint192(uint256(keccak256(abi.encodePacked(key))));

        return (rawTraits & ~KEY_MASK) | key;
    }

    function _decrypt(uint192 genes) internal pure returns (uint192) {
        uint192 key = KEY_MASK & genes;
        uint192 rawGenes = genes ^ uint192(uint256(keccak256(abi.encodePacked(key))));

        return (rawGenes & ~KEY_MASK) | key;
    }

    /// @param traitId head(1), eyes(2), back(3), feet(4), mouths(5), abilities(6)
    /// @param ancestor self(0)), paternal(1)), maternal(2))
    function _getTrait(uint192 genes, uint8 traitId, uint8 ancestor) internal pure returns (uint8) {
        return uint8((genes >> traitId) >> ancestor * 8);
    }

    /// @dev Generates a random int 0-100 with block timestamp
    // TODO: Consider if this is sufficiently unexploitable
    function _generateRandom() internal view returns (uint8) {
        return uint8(uint256(keccak256(abi.encodePacked(block.timestamp))) % 100);
    }
}