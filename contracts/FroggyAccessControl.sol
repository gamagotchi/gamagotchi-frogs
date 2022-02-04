// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @title FroggyAccessControl
 * Facet that manages administrative access to certain aspects of the game.
 */
contract FroggyAccessControl {

    address admin;
    
    /// @dev Modifer for functions only accessible to the admin.
    modifier onlyAdmin() {
        require(msg.sender == admin, "No admin access");
        _;
    }

    /// @dev Assigns a new address as the admin. Only available to the current admin.
    /// @param _admin The address of the new admin
    function setAdmin(address _admin) external onlyAdmin {
        admin = _admin;
    }

}