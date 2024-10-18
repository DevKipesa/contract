// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol"; // Import Forge's test utilities
import "../src/NFT.sol"; // Import the NFT contract

contract NFTTest is Test {
    NFT public nft;
    address public owner;
    address public user1;

    function setUp() public {
        // Deploy the NFT contract before each test
        nft = new NFT();

        // Set test accounts
        owner = address(this); // The owner is this contract
        user1 = address(0x123); // A sample user address
    }

    function testNameAndSymbol() public view {
        // Verify name and symbol
        assertEq(nft.name(), "NFT Name");
        assertEq(nft.symbol(), "NFT");
    }

    function testMinting() public {
        // Mint an NFT for user1
        uint256 tokenId = nft.mint{value: 0.1 ether}(user1);

        // Verify the token ID and ownership
        assertEq(tokenId, 1);
        assertEq(nft.ownerOf(1), user1);
    }

    function testIncrementTokenId() public {
        // Mint two NFTs and verify token ID increment
        nft.mint{value: 0.1 ether}(user1);
        assertEq(nft.currentTokenId(), 1);

        nft.mint{value: 0.1 ether}(user1);
        assertEq(nft.currentTokenId(), 2);
    }
}
