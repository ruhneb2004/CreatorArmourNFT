//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/// @title The main contract for Creator Armour NFT, handles minting and managing of NFT which are used to represent digital assets created by users and verify their ownership.
/// @author Benhur P Benny
/// @notice This is a simple NFT contract that allows users to mint NFTs with a specific URI, tracks the mint time and creator of each NFT, and provides basic functionality to retrieve this information.
/// @dev This contract extends OpenZeppelin's ERC721 and ERC721URIStorage to provide standard NFT functionality with additional features for mint time and creator tracking. Overall it's a simple implementation of an NFT contract that can be used to represent digital assets created by users, allowing them to mint NFTs with a specific URI and track the mint time and creator of each NFT.

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CreatorArmourNft is ERC721, ERC721URIStorage {
    uint256 private s_tokenCounter;
    mapping(uint256 => uint256) private s_tokenIdToMintTime;
    mapping(uint256 => address) private s_tokenIdToCreator;

    event NFTMinted(address creator, uint256 tokenId, string tokenUri, uint256 timestamp);

    constructor() ERC721("CreatorArmour", "CTA") {
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        uint256 tokenId = s_tokenCounter;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenUri);
        s_tokenIdToMintTime[tokenId] = block.timestamp;
        s_tokenIdToCreator[tokenId] = msg.sender;
        emit NFTMinted(msg.sender, tokenId, tokenUri, block.timestamp);
        s_tokenCounter++;
    }

    //returns the mint time of a given tokenId, which can be used to track when the NFT was minted and thereby resolve disputes or verify ownership.
    function mintTime(uint256 tokenId) public view returns (uint256) {
        return s_tokenIdToMintTime[tokenId];
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    //The creator of an NFT never changes, even if the NFT is transferred to another owner. This function allows anyone to query the creator of a specific tokenId.
    function creatorOf(uint256 tokenId) public view returns (address) {
        return s_tokenIdToCreator[tokenId];
    }

    function getCurrentTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}
