// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./IERC721Receiver.sol";

contract ERC721{

    mapping(address => uint256) internal balances;
    mapping(uint256 => address) internal tokenOwner;
    mapping(address => mapping(address => bool)) private operatorApproval;
    mapping(uint256 => address) private tokenApprovals;

    event Transfer(address from, address indexed to, uint indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approval);
    
    bytes4 internal constant ERC721_RECEIVED = bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    bytes4 internal constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    bytes4 internal constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

    function balanceOf(address owner) public view returns (uint256){
        require(owner != address(0), "Address zero!");
        return balances[owner];
    }

    function ownerOf(uint256 _tokenId) public view returns(address){
        address owner = tokenOwner[_tokenId];
        require(owner != address(0), "Token ID doesnt exist");
        return owner;
    }

    function setApprovalForAll(address operator, bool approval) external {
        operatorApproval[msg.sender][operator] = approval;
        emit ApprovalForAll(msg.sender, operator, approval);
    }

    function isApprovalForAll(address owner, address operator) public view returns(bool){
        return operatorApproval[owner][operator];
    }

    function approve(address _to, uint _tokenId) public {
        require(tokenOwner[_tokenId] == msg.sender || isApprovalForAll(msg.sender, _to), "Only for token owner or approved operators!");
        tokenApprovals[_tokenId] = _to;
    }

    function getApproved(uint256 _tokenId) public view returns(address){
        require(tokenOwner[_tokenId] != address(0), "Token ID does not exist!");
        return tokenApprovals[_tokenId];
    }

    function transferFrom(address _from, address _to, uint _tokenId) public {
        require(_from == msg.sender ||isApprovalForAll(_from, msg.sender) || tokenApprovals[_tokenId] == _from, "Only for approved operators!");
        require(tokenOwner[_tokenId] != address(0));
        require(_to != address(0));
        approve(address(0), _tokenId);
        _transfer(_from, _to, _tokenId);
        emit Transfer(_from, _to, _tokenId);

    }

    function safeTransferFrom(address _from, address _to, uint _tokenId, bytes memory _data) public {
        transferFrom(_from, _to, _tokenId);
        require(_checkERC721Receiver(_from, _to, _tokenId, _data) );
    }

    function safeTransferFrom(address _from, address _to, uint _tokenId) public {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    function supportsInterface(bytes4 _interfaceId) external virtual pure returns (bool){
        return ( _interfaceId == _INTERFACE_ID_ERC721 || _interfaceId == _INTERFACE_ID_ERC165);
    }

    function _transfer(address _from, address _to, uint _tokenId) internal {
        balances[_from] --;
        balances[_to] ++;
        tokenOwner[_tokenId] = _to;
    }

    function getTokenOwner(uint _tokenId) public view returns(address){
        return tokenOwner[_tokenId];
    }

    function _checkERC721Receiver(address _from, address _to, uint _tokenId, bytes memory _data) internal returns(bool){
        uint size;
        assembly{
            size := extcodesize(_to)
        }
        if(size > 0){
            bytes4 result = IERC721Receiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
            return result == ERC721_RECEIVED;
        }else {
            return true;
        }
    }
}