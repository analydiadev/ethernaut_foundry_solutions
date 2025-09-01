//SPDX:License-Identifier: MIT

pragma solidity ^0.8.13;

import "../src/Level0.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract Level0Solution is Script {

   Level0 public leve0Instance = Level0(0x9cc4c0ebCE7A8637C3a4c210edB60Bb995c87481);

   function run() external {
      string memory password = leve0Instance.password();
      console.log("Password: ", password);
      vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
      leve0Instance.authenticate(password);
      vm.stopBroadcast();
   }

}
