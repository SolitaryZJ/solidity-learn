// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract UserManager{
    struct User{
        string name;
        uint256 age;
        address wallet;
    }
    mapping(address => User) public users;
    function setUser(string memory name, uint256 age) public {
        users[msg.sender] = User(name, age, msg.sender);
    }
    function getUser(address add) public view returns (User memory){
        return users[add];
    }
}