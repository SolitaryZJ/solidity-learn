// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ErrorHandler{

    // 简单错误（不带参数）
    error Unauthorized();

    // 带参数的错误
    error InsufficientBalance(uint256 available, uint256 required);

    // 复杂参数的错误
    error TransferFailed(address from, address to, uint256 amount, string reason);

    function requireError(bool condition) public pure returns(uint256){
        require(condition, "condition is not true");
        return 1;
    }

    function assertError(bool condition) public pure returns(uint256){
        assert(condition);
        return 1;
    }

    function revertError(bool condition) public pure returns(uint256){
        if (!condition) {
            revert Unauthorized();
        }
        return 1;
    }
}

contract Bank {
    mapping(address => uint256) public balances;

    // 自定义修饰符，检查余额是否足够
    modifier hasSufficientBalance(uint256 amount) {
        require(balances[msg.sender] >= amount, "not enough!");
        _;
    }

    // 存款函数
    function deposit() public payable {
        require(msg.value > 0, "amount should great than 0");
        balances[msg.sender] += msg.value;
    }

    // 取款函数
    function withdraw(uint256 amount) public hasSufficientBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        assert(balances[msg.sender] >= 0); // 确保余额不为负
    }
}