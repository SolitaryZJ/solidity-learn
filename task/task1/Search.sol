// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Search{

    function search(uint[] memory arr, uint target) public pure returns (uint) {
        uint left = 0;
        uint right = arr.length - 1;
        while (left <= right) {
            uint mid = left + (right - left) / 2;
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
}