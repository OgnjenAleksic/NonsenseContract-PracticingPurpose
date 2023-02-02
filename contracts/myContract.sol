// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./modifier.sol";

contract myContract is Modifier {
    error myContract_EtherNotSent();

    address[] private depositors;
    uint256 private immutable i_minimum;

    address private myAddress = 0xc8338F5BE9c6D9562ab76000f86dC1cd5Fbae0b1;
    uint160 x = uint160(myAddress);

    //Strings and bytes!
    string sc =
        "Smart"
        "Contract";
    bytes public scBytes = bytes(sc);
    bytes public scBytesX2 = bytes.concat(scBytes, scBytes);
    string public scX2 = string(scBytesX2);

    //Nums and bytes!
    uint256 number = 50;
    bytes32 public numBytes = bytes32(number);
    bytes32 public addedNumBytes = bytes32(number + number);
    uint256 public addedNumbers = uint256(addedNumBytes);

    //Some functions
    constructor(uint256 _minimum) Modifier(_minimum) {
        i_minimum = _minimum;
    }

    function getContractCode(
        address contractAddress
    ) public view returns (bytes memory) {
        bytes memory contractCode = contractAddress.code;
        return contractCode;
    }

    function depositUsingSend(address _to) public payable minimumDeposit {
        bool sent = payable(_to).send(msg.value);
        if (!sent) revert myContract_EtherNotSent();
        depositors.push(msg.sender);
    }

    function depositUsingCall(address _to) public payable minimumDeposit {
        (bool sent /* bytes memory returnData */, ) = payable(_to).call{
            gas: 10000,
            value: msg.value
        }("");
        if (!sent) revert myContract_EtherNotSent();
        depositors.push(msg.sender);
    }

    function withdraw() public onlyOwner {}
}
