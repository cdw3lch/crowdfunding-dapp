// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract Crowdfunding {
    mapping(address => uint) public Contributors;
    address public manager;
    uint public minContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool isCompleted;
        uint noOfVoters;
        mapping (address => bool) voters;
    }

    mapping (uint => Request) public requests;
    uint public numRequests;
    constructor(uint _target, uint _deadline) {
        target = _target;
        deadline = block.timestamp + _deadline;
        minContribution = 100 wei;
        manager = msg.sender;
    }

    function sendEth() public payable {
        require(block.timestamp < deadline, "The deadline has passed.");
        require(msg.value >= 100 wei, "Minimum contribution not met.");

        if (Contributors[msg.sender] == 0) {
            noOfContributors++;
        }
        Contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function refund() public {
        require(block.timestamp > deadline && raisedAmount < target);
        require(Contributors[msg.sender]>0);
        address payable user = payable(msg.sender);
        user.transfer(Contributors[msg.sender]);
        Contributors[msg.sender]=0;
    }

    modifier onlyManager(){
        require(msg.sender == manager, "only manager can call this function");
        _;
    }

    function createRequest(string memory _description, address payable _recipient, uint _value) public onlyManager{
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.isCompleted = false;
        newRequest.noOfVoters = 0;

    }

    function voteRequest(uint _requestNo) public{
        require(Contributors[msg.sender]>0, "You are not a contributor.");
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false, "you have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public onlyManager {
        require(raisedAmount>=target);
        Request storage thisRequest = requests[_requestNo];
        require(thisRequest.isCompleted==false, "Already distributed amount");
        require(thisRequest.noOfVoters > noOfContributors /2, "majority support marks not crossed");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.isCompleted = true;

    }

}
