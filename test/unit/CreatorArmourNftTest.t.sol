// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.8.0 <0.9.0;

import {CreatorArmourNft} from "../../src/CreatorArmourNft.sol";
import {DeployCreatorArmourNFT} from "../../script/DeployCreatorArmourNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract CreatorArmourNftTest is Test {
    CreatorArmourNft creatorArmourNft;
    address user = makeAddr("Benhur");
    string tokenUri = "https://example.com/token/1";

    function setUp() public {
        DeployCreatorArmourNFT deployer = new DeployCreatorArmourNFT();
        creatorArmourNft = deployer.run();
    }

    function testMintIncrementsTokenCounter() public {
        uint256 initialCounter = creatorArmourNft.getCurrentTokenCounter();
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 newCounter = creatorArmourNft.getCurrentTokenCounter();
        assertEq(newCounter, initialCounter + 1, "Token counter should increment by 1 after minting");
    }

    function testMintSetsTokenURI() public {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;
        string memory retrievedUri = creatorArmourNft.tokenURI(tokenId);
        assertEq(retrievedUri, tokenUri, "Token URI should match the one set during minting");
    }

    function testMintSetsMintTime() public {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;
        uint256 mintTime = creatorArmourNft.mintTime(tokenId);
        assertNotEq(mintTime, 0, "Mint time should be greater than zero");
        assertGe(mintTime, block.timestamp, "Mint time should be close to the current block timestamp");
    }

    function testMintSetOwner() public {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;
        address owner = creatorArmourNft.ownerOf(tokenId);
        assertEq(owner, user, "Owner of the token should be the user who minted it");
    }

    function testTokenIdAndTokenCounterUpdatesCorrectly() external {
        uint256 tokenCounter = creatorArmourNft.getCurrentTokenCounter();

        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;
        assertEq(tokenId, tokenCounter, "Token ID should match the current token counter after minting");
        assertEq(
            creatorArmourNft.getCurrentTokenCounter(), tokenCounter + 1, "Token counter should increment after minting"
        );
    }

    function testMintingEmitsNFTMintedEvent() public {
        vm.expectEmit(true, true, true, true);
        emit CreatorArmourNft.NFTMinted(user, creatorArmourNft.getCurrentTokenCounter(), tokenUri, block.timestamp);
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
    }

    function testOwnerAndCreatorOfNftAfterMintingIsSame() external {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;
        address creator = creatorArmourNft.creatorOf(tokenId);
        address owner = creatorArmourNft.ownerOf(tokenId);
        assertEq(creator, owner, "Creator of the NFT should be the user who minted it");
    }

    function testNftTransferFailsIfNotOwner() external {
        vm.prank(user);
        creatorArmourNft.mintNFT(tokenUri);
        uint256 tokenId = creatorArmourNft.getCurrentTokenCounter() - 1;

        address anotherUser = makeAddr("AnotherUser");
        vm.expectRevert();
        vm.prank(anotherUser);
        creatorArmourNft.safeTransferFrom(user, anotherUser, tokenId);
    }
}
