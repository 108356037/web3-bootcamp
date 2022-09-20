// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

import "./Owned.sol";

contract EventExample is Owned {

    mapping(address => uint) public tokenBalance;

    event TokensSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[owner] = 100;
    }

    function sendToken(address payable _to, uint _amount) public payable returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "insufficient balance");
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
        _to.transfer(msg.value);

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }

}