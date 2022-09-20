// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract WorkingWithVars {

    // default is 0
    uint256 public myUint; 

    // default is false
    bool public myBool;

    // uint is alias of uint256
    function setMyUint(uint _myUint) public { 
        myUint = _myUint;
    }

    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }

    // default is 0
    uint8 public myUint8;

    // default will not deal with overflow
    function incrementUint8() public {
        myUint8++;
    }

    function decrementUint8() public {
        myUint8--;
    }

    // default is 0x0000000000000000000000000000000000000000
    address public myAddress;

    function setAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function getBalanceOfAddress() view public returns(uint) {
        return myAddress.balance;
    }

    // strings are internally stored as bytes array
    string public myString;

    // memory is a keyword used to store data for the execution of a contract. 
    // It holds functions argument data and is wiped after execution.
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}

