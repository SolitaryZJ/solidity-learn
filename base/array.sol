// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestArray {
    uint256[] public arr;// 没有初始化的数组
    uint256[] public arr2 = [1,2,3];// 初始化的数组
    uint256[] public arr3 = new uint256[](5);

    uint256[3] public staticArr;
    function readStaticArr() external view returns(uint256[3] memory data, uint256 len) {
        data = staticArr;
        len = staticArr.length;
    }
    uint256[3] public staticArr2 = [1,2,3];
    function readStaticArr1() external view returns(uint256[3] memory data, uint256 len) {
        data = staticArr2;
        len = staticArr2.length;
    }

    function readArr() external view returns(uint256[] memory data, uint256 len) {
        data = arr;
        len = arr.length;
    }

    function readArr2() external view returns(uint256[] memory data, uint256 len) {
        data = arr2;
        len = arr2.length;
    }

    function readArr3() external view returns(uint256[] memory data, uint256 len) {
        data = arr3;
        len = arr3.length;
    }
}