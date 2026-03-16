//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";


//Custom Errors
error InsufficientBalance(uint requested, uint available);
error ZeroAmount();
error TransferFailed();
error ZeroDeposit();


contract SavingsVault is Ownable, ReentrancyGuard, Pausable {
    mapping(address => uint) public balances;
    uint public totalVaultBalance;

    event Deposit(address indexed sender, uint amount);
    event Withdrawal(address indexed recipient, uint amount);

    constructor() Ownable(msg.sender) {}    

    function deposit() public payable {
        if(msg.value == 0) revert ZeroDeposit();

        balances[msg.sender] += msg.value;
        totalVaultBalance += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        if(msg.value == 0) revert ZeroDeposit();
       if(balancess[msg.sender] < amount) revert InsufficientBalance(amount, balances[msg.sender]);

        balances[msg.sender] -= amount;
        totalVaultBalance -= amount;

        (bool success,) = payable(msg.sender).call{value: amount  }("");
        if(!success) revert TransferFailed();
        emit Withdrawal(msg.sender, amount);
    }

    function pauseVault() public onlyOwner {
        _pause();
    }

    function unpauseVault() public onlyOwner {
        _unpause();
    }

    function getMyBalance() public view returns(uint) {
        return balances[msg.sender];
    }

    function getTotalVaultBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        if(msg.value == 0) revert ZeroDeposit();
        balances[msg.sender] += msg.value;
        totalVaultBalance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
}

