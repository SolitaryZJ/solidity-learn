// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BeggingContract{
    address private _owner;
    uint256 public minDonation = 0.001 ether;
    uint256 public totalDonation;
    mapping(address donator => uint256 amout) public donations;
    event DonationReceived(address indexed donator, uint256 amount);
    event DonationWithdrawn(address indexed recipient, uint256 amount);
    address[] public donatorList;
    
    constructor(uint256 _start, uint256 _end){
        _owner = msg.sender;
        require(_end > _start, "Invalid time");
        START_TIME = _start;
        END_TIME = _end;
    }

    modifier onlyOwner {
        require(msg.sender == _owner, "only contract owner can call this");
        _;
    }

    /* ==================== 时间限制 ==================== */
    uint256 public immutable START_TIME;
    uint256 public immutable END_TIME;

    modifier onlyInTimeWindow() {
        require(
            block.timestamp >= START_TIME && block.timestamp <= END_TIME,
            "Donation: not in time window"
        );
        _;
    }


    function donate() public payable onlyInTimeWindow returns(bool){
        donations[msg.sender] += msg.value;
        totalDonation += msg.value;
        donatorList.push(msg.sender);
        emit DonationReceived(msg.sender, msg.value);
        return true;
    }

    function withdraw() public payable onlyOwner returns(bool){
        totalDonation = 0;
        for (uint256 i = donatorList.length; i > 0; --i) {
            delete donations[donatorList[i]];
            donatorList.pop();
        }
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
