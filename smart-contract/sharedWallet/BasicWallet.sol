// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract BasicWallet is Ownable{

    bool public freezed;
    
    mapping(address => bool) public whiteList;

    event MoneyReceived(address indexed _from, uint _amount);
    event MoneySent(address indexed _to, uint _amount);

    constructor() {
        whiteList[msg.sender] = true;
    }

    modifier unFreezed {
        require(!freezed, "the wallet is currently freezed");
        _;
    }

    modifier whitelistOnly {
        require(whiteList[msg.sender], "you must be in whitelist to use this shared wallet");
        _;
    }

    function totalBalance() public view returns(uint) {
        return address(this).balance;
    }

    // directly use OpenZeppelin's onlyOwner modifier
    function setFreeze(bool _freeze) public onlyOwner {
        freezed = _freeze;
    }

    function addToWhiteList(address _newUser) public unFreezed onlyOwner {
        whiteList[_newUser] = true;
    }

    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }

    // receive() external payable {
    //     emit MoneyReceived(msg.sender, msg.value);
    // }
 
}