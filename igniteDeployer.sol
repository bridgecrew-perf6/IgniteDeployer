// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

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

    address private _owner;

    constructor() {
        _owner = msg.sender;
    }
   function depositIGT() external payable{}
    function withdrawIGT(uint256 value) external  {    
        require(msg.sender ==  _owner);

        payable(msg.sender).transfer(value);
    }
    function igtBalance() external view returns(uint){
        return address(this).balance;
    }

}
