//SPDX-License-Identifier: MIT


pragma solidity ^0.8.19;


contract UserRegistry {
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
    

    function registerUser(string memory _name,uint age) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(age >= 18, "You must be at least 18 years old");
        users[msg.sender] =  User({
            name: _name,
            email: "",
            age: age,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, "", age);
        totalUsers++;
    }

    function updateName(string memory newName) public {
        require(users[msg.sender].isRegistered, "User not registered");
        require(bytes(newName).length > 0, "Name cannot be empty");
        users[msg.sender].name = newName;
        emit UserUpdated(msg.sender, newName, users[msg.sender].email, users[msg.sender].age);
    }


    function getUser(address wallet) public view returns(string memory, uint, bool) {
        return (
            users[wallet].name,users[wallet].age,users[wallet].isRegistered
        );
    }
}