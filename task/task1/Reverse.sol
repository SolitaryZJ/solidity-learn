// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reverse{

    function reverse(string memory str) public pure returns (string memory){
        bytes memory data = bytes(str);
        uint length = data.length;
        for (uint i = 0; i < length / 2; i++) {
            (data[i], data[length - i - 1]) = (data[length - i - 1], data[i]);
        }
        return string(data);
    }
}