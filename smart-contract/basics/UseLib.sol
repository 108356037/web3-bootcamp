// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

import "./SafeMath.sol";
import "./Ownable.sol";

contract LibExample is Ownable {

    using SafeMath for uint;

    mapping(address => uint) public tokenBalance;

    event Received(address, uint);

    constructor() payable { 
        tokenBalance[msg.sender] = msg.value;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].sub(_amount);
        tokenBalance[_to] = tokenBalance[_to].add(_amount);

        return true;
    } 

    function getBalance(address _who) public view returns(uint) {
        return tokenBalance[_who];
    }

    // fallback() payable external {
    //     tokenBalance[msg.sender] = msg.value;
    //     emit Received(msg.sender, msg.value);
    // }

    receive() payable external {
        tokenBalance[msg.sender] = tokenBalance[msg.sender].add(msg.value);
        emit Received(msg.sender, msg.value); 
    }

}