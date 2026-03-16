//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/access/Ownable.sol";

contract MessageStore is Ownable {
    string public message;
    

    event MessageUpdated(string oldMessage, string newMessage);

    constructor (string memory initialMessage) Ownable(msg.sender) {}

    function updateMessage(string memory newMessage) public onlyOwner {
        require(bytes(newMessage).length > 0, "Message cannot be empty");
        string memory oldMessage = message;
        message = newMessage;
        emit MessageUpdated(oldMessage, newMessage);
    }

    function getMessage() public view returns(string memory) {
        return message;
    }
}