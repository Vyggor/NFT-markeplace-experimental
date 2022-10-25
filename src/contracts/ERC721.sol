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

// Mapping from tokenId to approved addresses

mapping(uint256 => address) private _tokenApprovals;

function balanceOf(address _owner) public view returns(uint256) {
    require(_owner != address(0), "cant be 0 address");
      return _OwnedTokensCount[_owner];
}

    function ownerOf(uint256 tokenId) public view returns (address){
        address owner = _tokenOwner[tokenId];
        require( owner != address(0), 'non existant');
        return owner;
    }


function _exists(uint256 tokenId) internal view returns(bool) {
    // setting the address of nft owner to check the mapping of the tokenId (if it already exists)
    address owner = _tokenOwner[tokenId];
    // return the truthfulness that the address is not zero
    return owner != address(0);
}


function _mint(address to, uint256 tokenId) internal virtual {
    require(to != address(0) , 'Cant mint to 0 address ');
   // we require that the function _exists with tokenId is false
    require(!_exists(tokenId), 'This token already mint');
    // we are assigning the tokenId to the address minting
    _tokenOwner[tokenId] = to;
    _OwnedTokensCount[to] += 1;

    emit Transfer(address(0), to, tokenId);
}

    
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param tokenId The NFT to transfer

    function _transferFrom(address _from, address _to, uint256 tokenId) internal{
        require(_to != address(0) ,"error transfer to 0 address");
        require(ownerOf(tokenId) == _from);
        _tokenOwner[tokenId] = _to;
        _OwnedTokensCount[_from] -= 1;
        _OwnedTokensCount[_to] += 1;

     emit Transfer(_from, _to, tokenId);

    // this function is internal because it s the main transfer function not the callable one in our
    //contract.
    }

    function transferFrom(address _from, address _to, uint256 tokenId) public payable {
        _transferFrom(_from, _to, tokenId);
    } // this is the actual callable function.


}