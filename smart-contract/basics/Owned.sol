// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }   

    // change the behaviors of functions
    // automatically check a pre-condition
    modifier onlyOwner() {
        require(msg.sender == owner,  "You are not the owner!");
        _;
    }
}