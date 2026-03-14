//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "./Ownable.sol";


contract SavingsVault is Ownable {
    mapping(address => uint) public balances;
    uint public totalVaultBalance;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed recipient, uint amount);

    receive() external payable {
        balances[msg.sender] += msg.value;
        totalVaultBalance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() public payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        totalVaultBalance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public {
        require(totalVaultBalance > 0, "No savings to withdraw");
        uint amountToWithdraw = balances[msg.sender];
        totalVaultBalance -= amountToWithdraw;
        (bool success,) = payable(msg.sender).call{value: amountToWithdraw}("");
        require(success, "Withdrawal failed");
        emit Withdrawal(msg.sender, amountToWithdraw);
    }

    function getMyBalance() public view returns(uint) {
        return balances[msg.sender];
    }
}

