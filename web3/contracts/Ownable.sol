//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

error NotOwner;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if(msg.sender != owner) revert NotOwner();
        _;
    }
}