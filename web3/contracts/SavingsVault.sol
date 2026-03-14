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

    function withdraw(uint amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance!");

        balances[msg.sender] -= amount;
        totalVaultBalance -= amount;

        (bool success,) = payable(msg.sender).call{value: amount  }("");
        require(success, "Withdrawal failed");
        emit Withdrawal(msg.sender, amount);
    }

    function getMyBalance() public view returns(uint) {
        return balances[msg.sender];
    }

    function getTotalVaultBalance() public view returns(uint) {
        return address(this).balance;
    }
}

