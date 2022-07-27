// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFT is ERC721 {
    using Counters for Counters.Counter;

    // constants
    uint256 public constant TOTAL_SUPPLY = 10_000;
    uint256 public constant MIN_PRICE = 0.04 ether;

    Counters.Counter private currentTokenId;

    string public baseTokenURI;

    constructor() ERC721("NFTTutorial", "NFT") {
        baseTokenURI = "";
    }

    // 铸造 NFT 给制定地址钱包 -> 通过交易
    function mintTo(address recipient) public payable returns (uint256) {
        uint256 tokenId = currentTokenId.current();
        require(tokenId < TOTAL_SUPPLY, "Max supply reached");
        require(msg.value == MIN_PRICE, "Transaction value did not equal the mint price");

        currentTokenId.increment();
        uint256 newItemId = currentTokenId.current();
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseTokenURI(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
    }
}
