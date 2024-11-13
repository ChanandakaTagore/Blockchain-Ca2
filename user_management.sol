// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/blob/v4.5.0/contracts/utils/cryptography/ECDSA.sol";


contract UserManagement {
    using ECDSA for bytes32;

    mapping(address => bool) public isAdmin;
    mapping(address => bool) public isRegularUser;

    event AdminAdded(address indexed admin);
    event RegularUserAdded(address indexed user);

    function addUsers(address[] calldata admins, address[] calldata regularUsers, bytes calldata signature) external {
        if (!isAdmin[msg.sender]) {
            bytes32 hashedData = keccak256(abi.encodePacked(admins, regularUsers));
            address signer = ECDSA.toEthSignedMessageHash(hashedData).recover(signature);
            require(isAdmin[signer], "Only admins can add users.");
        }

        for (uint256 i = 0; i < admins.length; i++) {
            isAdmin[admins[i]] = true;
            emit AdminAdded(admins[i]);
        }
        
        for (uint256 i = 0; i < regularUsers.length; i++) {
            isRegularUser[regularUsers[i]] = true;
            emit RegularUserAdded(regularUsers[i]);
        }
    }
}
