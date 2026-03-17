//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import "@openzeppelin/contracts/access/Ownable.sol";

//Custom Errors Handling
error EmptyMessage();
contract MessageStore is Ownable {
    string public message;
    

    event MessageUpdated(string oldMessage, string newMessage);

    constructor (string memory initialMessage) Ownable(msg.sender) {
        message = initialMessage;
    }


    //Updating Messages
    function updateMessage(string memory newMessage) public onlyOwner {
        if(bytes(newMessage).length ==0) revert EmptyMessage();
        string memory oldMessage = message;
        message = newMessage;
        emit MessageUpdated(oldMessage, newMessage);
    }
    

    //Getting the message sent
    function getMessage() public view returns(string memory) {
        return message;
    }
}