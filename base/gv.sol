// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockInfo {
    function getBlockDetails() public view returns (uint, uint) {
        return (block.number, block.timestamp);
    }
} 