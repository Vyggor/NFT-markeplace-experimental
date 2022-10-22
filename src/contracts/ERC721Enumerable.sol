// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

import './ERC721.sol';

contract ERC721Enunerable is ERC721 {

    uint256 [] private _allTokens;

    mapping (uint256 => uint256) private _allTokensIndex;

    mapping (address => uint256[]) private _ownedTokens;

    mapping (uint256 => uint256) private _ownedTokensIndex;


    
    
    


    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        // A. add tokens to the owner
        // B. add tokens to our totalsupply - to allTokens

        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId); //we are going to push the function to _mint function
        //to keep track of tokens added.
    }

    function totalSupply() public view returns(uint) {
        return _allTokens.length;
    }
}