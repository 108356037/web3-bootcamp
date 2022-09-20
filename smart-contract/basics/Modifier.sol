// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

import "./Owned.sol";

contract InheritanceModifierExample is Owned {
    
    mapping(address => uint) public tokenBalance;

    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[owner] = 100;
    }

    function createToken() public onlyOwner {
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner {
        tokenBalance[msg.sender]--;
    }

    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address payable _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "insufficient balance");
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        _to.transfer(_amount);
    }

}