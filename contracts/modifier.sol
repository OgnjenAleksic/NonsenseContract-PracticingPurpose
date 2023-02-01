// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Modifier {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() virtual {
        require(msg.sender == owner, "Only owner can withdraw the funds");
        _;
    }
}
