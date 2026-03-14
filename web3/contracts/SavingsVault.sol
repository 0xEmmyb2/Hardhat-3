//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "./Ownable.sol";


contract SavingsVault is Ownable {
    uint public totalSavings;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed recipient, uint amount);

    function deposit() public payable {
        require(msg.value > 0, "You must send some ether to deposit");
        totalSavings += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        require(totalSavings > 0, "No savings to withdraw");
        uint amountToWithdraw = totalSavings;
        totalSavings = 0;
        (bool success,) = payable(recipient).call{value: totalSavings}("");
        require(success, "Withdrawal failed");
        emit Withdrawal(recipient, amountToWithdraw);
    }

    function getMyBalance() public view returns(uint) {
        return totalSavings;
    }

