// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestInt{

    function GTOrEq(uint8 x, uint8 y) public pure returns(bool) {
        return x >= y;
    }

    function LTOrEq(uint8 x, uint8 y) public pure returns(bool) {
        return x <= y;
    }

    function GT(uint8 x, uint8 y) public pure returns(bool) {
        return x > y;
    }

    function LT(uint8 x, uint8 y) public pure returns(bool) {
        return x < y;
    }

    function EQ(uint8 x, uint8 y) public pure returns(bool) {
        return x == y;
    }

    function NEQ(uint8 x, uint8 y) public pure returns(bool) {
        return x != y;
    }

    // 2 ** 8 = 256 usigned -1 = 255 需要防止溢出 255 + 1
    // 1111 1111 -》256

    function add(uint8 x, uint8 y) public pure returns (uint8) {
        return x + y;
    }

    function uintsub(uint8 x, uint8 y) public pure returns (uint8) {
        return x - y;
    }

    function sub(int8 x, int8 y) public pure returns (int8) {
        return x - y;
    }
    
    function multiple(uint8 x, uint8 y) public pure returns (uint8) {
        return x * y;
    }
    
    function divide(uint8 x, uint8 y) public pure returns (uint8) {
        return x / y;
    }

    function modulo(uint8 x, uint8 y) public pure returns (uint8) {
        return x % y;
    }

    function exponentiation(uint8 x, uint8 y) public pure returns(uint8) {
        return x ** y;
    }
    // 0000 0011 -> 000 1100
    function leftShift(uint8 x, uint8 y) public pure returns(uint8) {
        return x << y;
    }

    function and(uint8 x, uint8 y) public pure returns(uint8) {
        return x & y;
    }

    function or(uint8 x, uint8 y) public pure returns(uint8) {
        return x | y;
    }

    function xor(uint8 x, uint8 y) public pure returns(uint8) {
        return x ^ y;
    }
}