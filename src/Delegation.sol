// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Objetive
// The goal of this level is for you to claim ownership of the instance you are given.

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    //@audit This function is going to be called every time that someone calls this smart contract without expecifing a signature hash.
    //@audit-issue Fallback can be called by the attacker by using "pwn()" of the "Delegate" smart contract and change the ownership.
    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}