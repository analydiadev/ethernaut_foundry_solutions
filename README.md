# Ethernaut Challenges - OpenZeppelin

This repository was created to solve the challenges from [Ethernaut](https://ethernaut.openzeppelin.com/), the smart contract hacking game developed by OpenZeppelin.

## Technologies Used

| Technologies Used | Description |
|-------------------|-------------|
| [Foundry](https://book.getfoundry.sh/) | **A fast and efficient framework for Solidity development, testing, and deployment.** |

## How to Run

1. **Install Foundry**:
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Install Dependencies**:
   ```bash
   forge install
   ```

## Project Structure

| Directory | Description |
|-----------|-------------|
| `src`     | Contracts and solutions |
| `test`    | Foundry tests to validate the solutions |
| `scripts` | Scripts for deployment and interactions |



[Jump to Found Vulnerabilities](#vulnerabilities)<img src="https://media.giphy.com/media/mBYkXvLxkHZFmqBHIC/giphy.gif" width=50px height=40px>



## Purpose

This repository serves as study material and practice for Smart Contract Security through the Ethernaut challenges.

## Vulnerabilities

This section lists the vulnerabilities found while solving the Ethernaut challenges. Each vulnerability includes a description.

- **Fallback Contract Vulnerability**
 
  
   The contract has a fallback function that requires msg.value to be greater than zero and the msg.sender’s contribution to be greater than zero. If these conditions are met, the fallback function transfers ownership to the caller. 
    
    🎯 **Exploit Scenario**

  An attacker can exploit this by first making a contribution, then sending WEI with an empty calldata (triggering the fallback), thereby gaining ownership of the contract.
  
  <br>

- **:robot: Fallout Contract Vulnerability**: 
  <br>
  

    The contract is named Fallout, but the function intended to act as the constructor is named Fal1out (with a digit "1" instead of an "l"). Because of this typo, the function is not recognized as a constructor, and is instead treated as a regular public payable function. Upon deployment, the owner variable remains at its default value: address(0). 
    
    🎯 **Exploit Scenario**

    Since Fal1out is a public function, anyone can call it and set themselves as the owner by sending a transaction. Consequently, ownership is uninitialized and can be claimed by anyone.


    <br>
- **🧩 CoinFlip Contract Vulnerability**: 

  The contract uses blockhash(block.number - 1) to generate randomness which is predictable because the previous block hash is public and can be known by anyone. Miners can also manipulate the block to influence the outcome.

  🎯 **Exploit Scenario**

  An attacker can create a contract that replicates the CoinFlip logic, calculates the coin flip result from the previous block hash, and calls flip() with the predicted outcome, ensuring a win every time.
    
    <br>
 
- **:telephone: Telphone Contract Vulnerability**: 

    When calling changeOwner directly from your EOA, tx.origin equals msg.sender, so the require condition tx.origin != msg.sender fails and the ownership cannot change. However, if an EOA account calls an intermediary malicious contract, the vulnerability can be exploited since tx.origin will not be the same as msg.sender. 

    🎯 **Exploit Scenario**
    
    An attacker can use an EOA (Externally Owned Account) as tx.origin to start a transaction, which then calls a malicious contract that executes a function to change the ownership.
    
    <br>

 
 - 📊 **Token Contract Vulnerability**

    In Solidity version 0.6, arithmetic operations like subtraction do not automatically check for underflow or overflow.

    ``If balances[msg.sender] = 20 and _value = 21`` then:

     ``20 - 21 causes an underflow``

    Since uint256 can't be negative, it wraps around to a huge number:
    
    ``2^256 - 1 = 115792089237316195423570985008687907853269984665640564039457584007913129639935``

    The require still passes, because that number is greater than 0.

    🎯 **Exploit Scenario**

    An attacker can call the transfer() function with a value greater than their balance, causing underflow and gaining a massive token balance.  

    <br>

  - 🔥 **Delegation Contract Vulnerability**

    The Delegation contract uses delegatecall inside its fallback function to forward calls to a Delegate contract. This allows external code execution in the context of Delegation, including access to its storage.

    🎯 **Exploit Scenario**

     An attacker can call Delegation with the pwn() function signature. Since the fallback uses delegatecall, the pwn() function runs in Delegation's context, changing its owner to the attacker.


