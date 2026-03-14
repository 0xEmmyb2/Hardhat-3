//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "./Ownable.sol";


contract SavingsVault is Ownable {
    uint public totalSavings;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed recipient, uint amount);

    receive() external payable {
        (bool success,) = payable(msg.sender).call{value: msg.value}("");
        require(success, "Deposit failed");
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        require(totalSavings > 0, "No savings to withdraw");
        uint amountToWithdraw = totalSavings;
        totalSavings = 0;
        (bool success,) = payable(msg.sender).call{value: totalSavings}("");
        require(success, "Withdrawal failed");
        emit Withdrawal(msg.sender, amountToWithdraw);
    }

    function getMyBalance() public view returns(uint) {
        return totalSavings;
    }

