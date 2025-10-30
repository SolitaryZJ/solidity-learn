// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestLoop{
    // 无初始化语句
    function forWithoutNoInit() public pure{
        uint i = 0;
        for (; i < 10; i++) {
            // 循环体
        }
    }
    // 无条件语句
    function forWithoutCondition() public pure{
        for (uint i = 0; ; i++) {
            if (i >= 10) break;
            // 循环体
        }
    }
    // 无递增语句
    function forWithNoIncrement() public pure{
        for (uint i = 0; i < 10; ) {
            // 循环体
            i++;
        }
    }

    function basicWhile() public pure returns(uint){
        uint sum = 0;
        uint i = 0;
        while (i < 10) {
            sum += i;
            i++;
        }
        return sum;
    }

    function basicDoWhile() public pure returns(uint){
        uint sum = 0;
        uint i = 0;
        do {
            sum += i;
            i++;
        } while(i < 10);
        return sum;
    }
    // 通过16进制初始化
    bytes public bs = "abc\x22\x22";
    // 长度10字节数组
    bytes public _data = new bytes(10);

    string public str0;
    string public str1 = "abchdbgsga";

    function readBytesByIndex(uint256 index) public view returns(bytes1){
        return bs[index];
    }

    function readBytesIndexByBytes(bytes1 d) public view returns(int256){
        for (uint256 i=0; i<bs.length; i++) {
            if (bs[i]==d) {
                return int256(i);
            }
        }
        return -1;
    }
    // slice只支持calldata
    function tesSlice(bytes calldata data, uint256 start, uint256 end) public pure returns(bytes memory){
        return data[start:end];
    }
}