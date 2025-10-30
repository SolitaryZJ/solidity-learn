// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{
    mapping(address => uint256) votes;

    function vote(address addr) public{
        votes[addr] += 1;
    }

    function getVotes(address addr) public view returns(uint256){
        return votes[addr];
    }

    function resetVotes(address addr) public {
        votes[addr] = 0;
    }
}