// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyERC20{

    mapping(address account => uint256 amount) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function _mint(address account, uint256 value) internal {
        this.transfer(account, value);
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(value > 0, "Must great than 0");
        require(_balances[msg.sender] >= value, "Not enough balance");
        _balances[msg.sender] -= value;
        _balances[to] += value;
        return true;
    }


    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }
    
    function approve(address spender, uint256 value) external returns (bool) {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool){
        require(_balances[from] >= value, "Not enough balance");
        require(_allowances[from][msg.sender] >= value, "Not enough balance");
        _allowances[from][msg.sender] -= value;
        _balances[from] -= value;
        _balances[to] += value;
        return true;
    }
}