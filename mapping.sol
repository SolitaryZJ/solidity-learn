// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceTracker{
    mapping(address account => uint256 amount) public balance;
    function setBalance(address account, uint256 amount) public {
        balance[account] = amount;
    }

    function getBalance(address account) public view returns (uint256){
        return balance[account];
    }
     mapping(address => mapping(string => uint256)) public userBalances;
    function setUserBalance(string memory currency, uint256 amount) public {
        userBalances[msg.sender][currency] = amount;
    }
    function getUserBalance(address user, string memory currency) public view returns (uint256) {
        return userBalances[user][currency];
    }
}