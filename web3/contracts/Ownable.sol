//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;


contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
}