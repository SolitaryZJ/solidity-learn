// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BeggingContract{
    address private _owner;
    uint256 public minDonation = 0.001 ether;
    uint256 public totalDonation;
    mapping(address donator => uint256 amout) public donations;
    event DonationReceived(address indexed donator, uint256 amount);
    event DonationWithdrawn(address indexed recipient, uint256 amount);

    constructor(){
        _owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "only contract owner can call this");
        _;
    }

    function donate() public payable returns(bool){
        donations[msg.sender] += msg.value;
        totalDonation += msg.value;
        emit DonationReceived(msg.sender, msg.value);
        return true;
    }
    function withdraw() public payable onlyOwner returns(bool){
        totalDonation = 0;
        payable(msg.sender).transfer(totalDonation);
        emit DonationWithdrawn(msg.sender, totalDonation);
        return true;
    }
    function getDonation(address donator) public view returns (uint256){
        return donations[donator];
    }

    receive() external payable { 
        donate();
    }
}