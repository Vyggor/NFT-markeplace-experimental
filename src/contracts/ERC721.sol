// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

contract ERC721 {

event Transfer(
    address indexed from, 
    address indexed to, 
    uint256 indexed tokenId);
    /* 

    building out the minting function:
    
       we want the nft to point to an address
       to keep track of the token ids
       keep track of token owner addresses to token ids
       keep track of how many token an owner adress has
       create even that emits a transfer log - contract address, where it is being minted to, id.

*/ 

// mapping in solidity creates a hash table of key-pair values
// Mapping from token id to owner

mapping(uint256 => address) private _tokenOwner; 

// Mapping from owner to number of owned tokens

mapping(address => uint256) private _OwnedTokensCount;

function _exists(uint256 tokenId) internal view returns(bool) {
    // setting the address of nft owner to check the mapping of the tokenId (if it already exists)
    address owner = _tokenOwner[tokenId];
    // return the truthfulness that the address is not zero
    return owner != address(0);
}


function _mint(address to, uint256 tokenId) internal  {
    require(to != address(0) , 'Cant mint to 0 address ');
   // we require that the function _exists with tokenId is false
    require(!_exists(tokenId), 'This token already mint');
    // we are assigning the tokenId to the address minting
    _tokenOwner[tokenId] = to;
    _OwnedTokensCount[to] += 1;

    emit Transfer(address(0), to, tokenId);
}




}