// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Objectives
// 1. Claim ownership of this contract
// 2. Drain it's ETH

contract Fallback {
    
    mapping(address => uint256) public contributions;
    address public owner;

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }


    function contribute() public payable {
    //Require the msg.value to be send with less than 0.001 ether
        require(msg.value < 0.001 ether);
    
    // Increment the contribution plus the new contribution that was sent.   
        contributions[msg.sender] += msg.value;

    //If the msg.sender has more contribution than the actual owner the ownership is going to be pass to the 
    //Current msg.sender
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    //Only the owner can call the withdraw function
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    //The require asks the msg.value to be greater than zero and the contribution to be greater than 0.
    //The ownership is going to pass to the msg.sender without a require statement. 
    //To claim ownership I must trigger the fallback function.
    
    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}