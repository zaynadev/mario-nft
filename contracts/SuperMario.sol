//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./ERC721.sol";

contract SuperMario is ERC721{
    string public name;
    string public symbol;
    uint public tokenCount; 
    mapping(uint => string) private tokenURIs;
    bytes4 internal constant _INTERFACE_ID_ERC721METADATA = 0x5b5e139f;


    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }

    function tokenURI(uint tokenId) public view  returns(string memory) {
        require(getTokenOwner(tokenId) != address(0), "Token does not exist");
        return tokenURIs[tokenId];
    }

    function mint(string memory _tokenURI) external {
        tokenCount ++;
        tokenOwner[tokenCount] = msg.sender;
        balances[msg.sender] ++;
        tokenURIs[tokenCount] = _tokenURI;
    }

    function supportsInterface(bytes4 _interfaceId) external override pure returns (bool){
        return ( _interfaceId == _INTERFACE_ID_ERC721 || _interfaceId == _INTERFACE_ID_ERC165);
    }
}