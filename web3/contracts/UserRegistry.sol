//SPDX-License-Identifier: UNLICENSED

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;


contract UserRegistry {
    struct User{
        string name;
        string email;
        string age;
        bool isRegistered;
    }

    address public owner;
    mapping(address => User) public users;
    uint public totalUsers;

    event UserRegistered(address indexed userAddress, string name, string email, string age);
    event UserUpdated(address indexed userAddress, string name, string email, string age);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function registerUser(string memory _name,uint age) public {
        require(!users[msg.sender].isRegistered, "User already registered");'
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
        emit UserUpdated(msg.sender, newName);
    }


    function getUser(address wallet) public view returns(string memory, uint, bool) {
        return (
            users[wallet].name,
            users[wallet].age,
            users[wallet].isRegistered,
        );
    }
}