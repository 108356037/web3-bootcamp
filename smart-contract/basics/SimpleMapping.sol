// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract SimpleMapping {
    
    // All key/value pairs are initialized with their default value.
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public whiteListMapping;
    mapping(uint => mapping(uint => bool)) public nestedMapping;

    function SetMapVal(uint _index) public {
        myMapping[_index] = true;
    }

    function SetWhiteList() public {
        whiteListMapping[msg.sender] = true;
    }

    function GetNestedMapVal(uint _index1, uint _index2) view public returns(bool) {
        return nestedMapping[_index1][_index2];
    }

    function SetNestedMapVal(uint _index1, uint _index2, bool _val) public {
        nestedMapping[_index1][_index2] = _val;
    }

}