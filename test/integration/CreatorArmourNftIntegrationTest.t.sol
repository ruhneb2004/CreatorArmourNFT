// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.8.0 <0.9.0;

import {CreatorArmourNft} from "../../src/CreatorArmourNft.sol";
import {DeployCreatorArmourNFT} from "../../script/DeployCreatorArmourNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract CreatorArmourNftIntegrationTest is Test {
    CreatorArmourNft creatorArmourNft;
    address user = makeAddr("Benhur");
    string tokenUri = "https://example.com/token/1";

    function setUp() public {
        DeployCreatorArmourNFT deployer = new DeployCreatorArmourNFT();
        creatorArmourNft = deployer.run();
    }

    function testNftTransferAfterMinting() external {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);

        address reciever = makeAddr("ruhneb");
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;

        vm.prank(user);
        creatorArmourNft.safeTransferFrom(user, reciever, tokenId);

        address ownerAfterTransfer = creatorArmourNft.ownerOf(tokenId);
        assertEq(ownerAfterTransfer, reciever, "Reciever should be the current owner of the NFT!");
        assertEq(
            user,
            creatorArmourNft.creatorOf(tokenId),
            "Even after transfer the creator of the nft must remain the same!"
        );
    }
}
