// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        this;
        return msg.data;
    }
}

 contract Ownable is Context {
    address private _owner;
    
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
}

contract igniteDeployer is Ownable  {

    uint256 private pass = 999999999;
    address public admin;
    mapping(address => bool) public authorized;

    constructor() {
        admin = msg.sender;
    }

     modifier onlyAuthorized()  {
        require(authorized[msg.sender] || owner() == msg.sender);
        _;
    }

    function addAuthorized(address _toAdd) onlyOwner public {
        require(_toAdd != address(0));
        authorized[_toAdd] = true;
    }

    function removeAuthorized(address _toRemove) onlyOwner public {
        require(_toRemove != address(0));
        require(_toRemove != msg.sender);
        authorized[_toRemove] = false;
    }
    
   function depositIGT() external payable{}
    function withdrawIGT(address payable recipeint, uint256 value,uint256  transactionKey) external  {    
        require(msg.sender ==  admin || authorized[msg.sender] == true);
        require(pass == transactionKey);
        require(msg.sender == recipeint);
        recipeint.transfer(value);
    }
    function igtBalance() external view returns(uint){
        return address(this).balance;
    }

}