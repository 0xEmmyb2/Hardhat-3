//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


error ZeroAmount();
error ZeroAddress();


contract LearnToken is ERC20, ERC20Burnable, Ownable {

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);
    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    constructor(uint256 initialSupply) ERC20("LearnToken", "LRN") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        if(amount == 0) revert ZeroAmount();
        if(to == address(0)) revert ZeroAddress();
        _mint(to, amount * 10 ** decimals());
        emit TokensMinted(to, amount);
    }

    function burnTokens(uint256 amount) public {
        if(amount == 0) revert ZeroAmount();
        burn(amount * 10 ** decimals());
        emit TokensBurned(msg.sender, amount);
    }

    function transferTokens(address to, uint256 amount) public  returns(bool) {
        if(amount == 0) revert ZeroAmount();
        if(to == address(0)) revert ZeroAddress();
        emit TokensTransferred(msg.sender, to, amount);
        return transfer(to, amount * 10 ** decimals()); // ERC20 Transfer
    }

    function getBalance(address account) public view returns(uint256) {
        return balanceOf(account) / 10 ** decimals();
    }
}