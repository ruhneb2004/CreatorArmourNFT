// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.8.0 <0.9.0;

import {CreatorArmourNft} from "../src/CreatorArmourNft.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployCreatorArmourNFT is Script {
    function run() external returns (CreatorArmourNft) {
        vm.startBroadcast();
        CreatorArmourNft creatorArmourNft = new CreatorArmourNft();
        vm.stopBroadcast();

        console.log("CreatorArmourNft deployed to:", address(creatorArmourNft));
        return creatorArmourNft;
    }
}
