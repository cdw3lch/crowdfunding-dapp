// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract Crowdfunding{
    mapping (address => uint) public Contributors;
    address public manager;
    uint public minContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;


constructor(uint _target, uint _deadline){
    target = _target;
    deadline = block.timestamp + _deadline;
    minContribution = 100 wei;
    manager = msg.sender;
}

function sendEth() public payable{
    require(block.timestamp < deadline, "The deadline has passed.");
    require(msg.value >= 100 wei, "Minimum contribution not met.");

    if(Contributors[msg.sender]==0){
        noOfContributors++;
    }
    Contributors[msg.sender]+=msg.value;
    raisedAmount+= msg.value;
}

function getContractBalance() public view returns(uint){
    return address(this).balance;
}

}