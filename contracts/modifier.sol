// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Modifier {
    address payable owner;
    uint256 private i_minimum;

    constructor(uint256 _minimum) {
        owner = payable(msg.sender);
        i_minimum = _minimum;
    }

    modifier onlyOwner() virtual {
        require(msg.sender == owner, "Only owner can withdraw the funds");
        _;
    }

    modifier minimumDeposit() virtual {
        require(msg.value >= i_minimum, "Your deposit is less than minimum");
        _;
    }
}
