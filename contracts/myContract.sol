// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./modifier.sol";

contract myContract is Modifier {
    error myContract_EtherNotSent();

    uint256 private immutable i_minimum;
    address[] private depositors;

    address private myAddress = 0xc8338F5BE9c6D9562ab76000f86dC1cd5Fbae0b1;
    uint160 x = uint160(myAddress);

    constructor(uint256 _minimum) {
        i_minimum = _minimum;
    }

    function getContractCode(
        address contractAddress
    ) public view returns (bytes memory) {
        bytes memory contractCode = contractAddress.code;
        return contractCode;
    }

    function depositUsingSend(address _to) public payable {
        require(
            msg.value > i_minimum,
            "You deposited less than minimum amount"
        );
        bool sent = payable(_to).send(msg.value);
        if (!sent) revert myContract_EtherNotSent();
        depositors.push(msg.sender);
    }

    function depositUsingCall(address _to) public payable {
        require(
            msg.value > i_minimum,
            "You deposited less than minimum amount"
        );
        (bool sent /* bytes memory returnData */, ) = payable(_to).call{
            gas: 10000,
            value: msg.value
        }("");
        depositors.push(msg.sender);
        if (!sent) revert myContract_EtherNotSent();
    }

    function withdraw() public onlyOwner {}
}
