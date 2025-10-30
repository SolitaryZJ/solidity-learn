// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressExample{

    // 声明一个地址变量
    address public myAddress;

    // 获取当前调用者的地址
    address public caller = msg.sender;

    // 地址类型之间的比较
    function compareAddress(address addr1, address addr2) public pure returns (bool) {
        return addr1 == addr2;
    }

    // 地址类型的转换
    function toBytes(address addr) public pure returns (bytes memory) {
        return abi.encodePacked(addr);
    }

    // 获取地址的余额
    function getBalance(address addr) public view returns (uint256) {
        return addr.balance;
    }

    // 向地址转账
    function sendEther(address payable recipient) public payable {
        recipient.transfer(msg.value);
    }

    // 调用地址的代码（低级别调用）
    function callContract(address addr, bytes memory data) public returns (bool, bytes memory) {
        (bool success, bytes memory result) = addr.call(data);
        return (success, result);
    }
}

// 定义一个简单的接口
interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract MyContract {
    // 使用接口与另一个合约交互
    function transferToken(address tokenAddress, address to, uint256 amount) public returns (bool) {
        IERC20 token = IERC20(tokenAddress);
        return token.transfer(to, amount);
    }

    // 获取代币余额
    function getTokenBalance(address tokenAddress, address account) public view returns (uint256) {
        IERC20 token = IERC20(tokenAddress);
        return token.balanceOf(account);
    }
}