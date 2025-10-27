// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
contract Hello3Dot0{
    // string public hello = "hello web3.0!";
    // int public account = 1* 2**255-1;
    // uint public a2 = 1*2**256-1;
    // bool public flag1 = false;
    // bool public flag2 = true;
    // //address public addr = 0x9854251557468751264; // 16进制20位，由keccack265生成的

    // bytes32 public byt = hex"1000";// 16进制,两位表示一个字节

    // enum status {
    //     Active,
    //     Inactive
    // }
    // int[] public arr1;
    // string[] public arr2;
    // bool[] public arr3;
    // address[] public arr4;
    // bytes32[] public arr5;
    // struct Person {
    //     uint8 age;
    //     bool sex;
    //     string name;
    // }
    // Person public per1 = Person(18, true, "zhangsan");
    // Person public per2 = Person({age:18, sex:true, name:"zhangsan"});

    string public hello = "hello, ";
    function sayhello(string memory name) public view returns (string memory) {
        return string.concat(hello, name);
    }
}