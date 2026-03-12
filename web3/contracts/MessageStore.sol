//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

contract MessageStore {
    string public message;
    address public owner;


    event MessageUpdated(string oldMessage, string newMessage);

    constructor(string memory initialMessage) {
        message = initialMessage;
        owner = msg.sender;
    }

    function updateMessage(string memory newMessage) public {
        require(msg.sender == owner, "Only the owner is allowed to update the message");
        require(bytes(newMessage).length > 0, "Message cannot be empty");
        message = newMessage;
        emit MessageUpdated(message, newMessage);
    }

    function getMessage() public view returns(string memory) {
        return message;
    }
}