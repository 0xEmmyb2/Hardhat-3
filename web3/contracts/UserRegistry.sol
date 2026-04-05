//SPDX-License-Identifier: MIT


pragma solidity ^0.8.19;


//Custom errors
error UserAlreadyRegistered();
error UserNotLegible(); 
error InvalidName();
error UserNotAlreadyRegistered();


contract UserRegistry {

    //Defining the User and the attributes of the user
    struct User{
        string name;
        string email;
        uint age;
        bool isRegistered;
    }

    address public owner;
    mapping(address => User) public users;
    uint public totalUsers;

    event UserRegistered(address indexed userAddress, string name, string email, uint age);
    event UserUpdated(address indexed userAddress, string name, string email, uint age);

    constructor() {
        owner = msg.sender;
    }
    

    //Registry of the user
    function registerUser(string memory _name,uint age) public {
        if (users[msg.sender].isRegistered) revert UserAlreadyRegistered();
        if (bytes(_name).length == 0) revert InvalidName();
        if (age < 18) revert UserNotLegible();
        users[msg.sender] =  User({
            name: _name,
            email: "",
            age: age,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, "", age);
        totalUsers++;
    }

    //Changing the username of the user
    function updateName(string memory newName) public {
        if(!users[msg.sender].isRegistered) revert UserNotAlreadyRegistered();
        if (bytes(newName).length == 0) revert InvalidName();
        users[msg.sender].name = newName;
        emit UserUpdated(msg.sender, newName, users[msg.sender].email, users[msg.sender].age);
    }


    function getUser(address wallet) public view returns(string memory, string memory, uint, bool) {
        return (
            users[wallet].name,users[wallet].email,users[wallet].age,users[wallet].isRegistered
        );
    }
}