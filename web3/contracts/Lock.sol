//SPDX-License-Identifier: UNLICENSED


pragma solidity ^0.8.19;

contract Lock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(block.timestamp < _unlockTime, "Must be future time");
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdrawal() public {
        require(block.timestamp >= unlockTime, "Too early to withdraw!");
        require(msg.sender == owner, "You aren't the owner!");

        emit Withdrawal(address(this).balance, block.timestamp);
        owner.transfer(address(this).balance);
        
    }
}