// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MembershipNFT is ERC721Enumerable, Ownable {
    uint256 public nextTokenId;
    address public daoAddress;
    mapping(address => bool) public hasMembership;

    constructor(address _daoAddress) ERC721("Movie DAO Membership", "MDM") Ownable(_daoAddress) {
        daoAddress = _daoAddress;
    }

    function mint(address to) external {
        require(msg.sender == daoAddress, "Only DAO can mint");
        require(!hasMembership[to], "User already has membership");

        uint256 tokenId = nextTokenId++;
        _safeMint(to, tokenId);
        hasMembership[to] = true;
    }
}
