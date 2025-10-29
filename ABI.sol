// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Application Binary Interface 应用二进制接口
contract ABI {
    // 1.编码
    function encodeData(string memory text, uint256 number) public pure returns(bytes memory, bytes memory) {
       return (
            abi.encode(text, number),
            abi.encodePacked(text, number)
        );
    }
    // 2.解码
    function dencodeData(bytes memory encoded) public pure returns(string memory text, uint256 number){
        return abi.decode(encoded, (string, uint256));
    }

    // 3.获取当前函数签名
    function getSelector() public pure returns(bytes4) {
        return msg.sig;
    }
    // 4.计算函数选择器
    function computeSelector(string memory func) public pure returns(bytes4){
        return bytes4(keccak256(bytes(func)));
    }

    //  0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000064
    function transfer(address addr, uint256 amount) public pure returns(bytes memory) {
        return msg.data;
    }

    // 5.调用函数生成msg.data
    // 0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000000000064
    function encodeFunctionDataCall() public pure returns (bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,100);
    }
    // 6.哈希运算
    function hashFunctions(string memory input) public pure returns(bytes32, bytes32, bytes32) {
        bytes memory data = abi.encodePacked(input);
        return (
            keccak256(data),// keccak256
            sha256(data),// sha256
            ripemd160(data)
        );
    }
    // 7. 数学运算
    function modularmath(uint256 x, uint256 y, uint256 m) public pure returns(uint256, uint256){
        return (
            addmod(x, y, m),
            mulmod(x, y, m)
        );
    }
    // 8.椭圆曲线回复公钥（errecover）
    function errecoverAddress(bytes32 hash, uint256 v, uint256 r, uint256 s) public pure returns(address) {
        return ecrecover(hash, v, r, s);
    }
}