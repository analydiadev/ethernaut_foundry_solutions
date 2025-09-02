// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
import "@openzeppelin-06/contracts/math/SafeMath.sol";

// The goal of this level is for you to steal all the funds from the contract.
//Objective: 
contract Reentrance {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

  
  //@audit-issue Vulnerable to Reentrancy (Does not follow the CEI patterns) "Checks, Effects, Interactions".

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            //@audit-issue vulnerable to arithmetic underflow
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}