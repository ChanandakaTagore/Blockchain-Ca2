# User Management Smart Contract

This smart contract allows a set of administrators to add new admins and regular users. Only authorized admins are permitted to add users, ensuring security within the system. It leverages the OpenZeppelin library to verify signatures and authenticate admins.

## Features

- **Admin Authentication:** Only authorized admins can add new users.
- **Event Logging:** Events are emitted when new admins and regular users are added.
- **Signature Verification:** Uses the OpenZeppelin ECDSA library to verify signed data and ensure the caller’s authorization.

## Code Structure

This contract has two primary mappings:
- `isAdmin`: Tracks addresses with admin privileges.
- `isRegularUser`: Tracks addresses with regular user privileges.

### Contract Breakdown

The main function of the contract is:
- `addUsers(address[] calldata admins, address[] calldata regularUsers, bytes calldata signature)`: 
  - Adds a list of admins and regular users to the contract.
  - Verifies the caller is an admin, either directly or via a valid signature.
  - Emits events when admins or users are added.

## Core Issue and Fix

### Issue
The initial code lacks event emission, making it difficult to track when new users are added. Additionally, it doesn't use OpenZeppelin's ECDSA library for signature recovery, leading to potential security vulnerabilities in signature verification.

### Fix
- **Event Emission**: Added `AdminAdded` and `RegularUserAdded` events to log actions.
- **Signature Verification**: Updated to use OpenZeppelin’s `ECDSA.toEthSignedMessageHash()` for secure signature verification.

## Getting Started

### Prerequisites

Ensure you have Solidity 0.8.0 or later installed to use this smart contract.

### Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/your-repo.git
    ```

2. Install [OpenZeppelin contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) as dependencies:
    ```bash
    npm install @openzeppelin/contracts
    ```

### Usage

1. Deploy the contract using Remix or your preferred Ethereum development environment.
2. To add users:
   - Call the `addUsers()` function with arrays of addresses for admins and regular users.
   - If you’re not an admin, provide a valid signature.

## Example

Here’s an example of how the contract can be deployed and used:

```solidity
// Deploy contract
UserManagement userManagement = new UserManagement();

// Call addUsers function
address;
admins[0] = 0x123...;  // replace with admin address
address;
users[0] = 0xabc...;   // replace with user address
bytes memory signature = 0x...; // replace with a valid signature

userManagement.addUsers(admins, users, signature);
```

## License

This project is licensed under the MIT License.
