// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInt{
    mapping(bytes1 => uint256) public romanToIntMap;

    constructor(){
        romanToIntMap["I"] = 1;
        romanToIntMap["V"] = 5;
        romanToIntMap["X"] = 10;
        romanToIntMap["L"] = 50;
        romanToIntMap["C"] = 100;
        romanToIntMap["D"] = 500;
        romanToIntMap["M"] = 1000;
    }

    function romanToInt(string memory str) public view returns(uint256){
        bytes memory data = bytes(str);
        uint256 total = 0;
        for (uint256 i = 0; i < data.length - 1; i++) {
            (uint256 x, uint256 y) = (romanToIntMap[data[i]], romanToIntMap[data[i + 1]]);
            if ( x < y ) {
                total -= x;
            } else {
                total += x;
            }
        }
        return total + romanToIntMap[data[data.length-1]];
    }
}