// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    uint public count;
    event Increased(uint newCount, address indexed sender);
    function increase() public {
        count++;
        emit Increased(count, msg.sender);
    }
}