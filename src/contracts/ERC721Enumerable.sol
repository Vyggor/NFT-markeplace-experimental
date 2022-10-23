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

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {

        _allTokensIndex[tokenId] = _allTokens.length;  //token index receives the value of the position in the array
       _allTokens.push(tokenId); //we are going to push the function to _mint function
        //to keep track of tokens added.
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
           _ownedTokens[to].push(tokenId);
           _ownedTokensIndex[tokenId]= _ownedTokens[to].length;
    }

    function tokenByIndex(uint256 index) public view returns(uint256) {
            require(index < totalSupply(), 'global index beyond total supply!');
            return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 index) public view returns(uint256) {
        require(balanceOf(_owner) > index, 'owner index out of bounds');
        return _ownedTokens[_owner][index];
    }

    function totalSupply() public view returns(uint) {
        return _allTokens.length;
    }
}