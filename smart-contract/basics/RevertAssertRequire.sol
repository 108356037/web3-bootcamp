// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract ExceptionExample {

    mapping(address => uint8) public balanceMap;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function destroyContract() public {
        require(msg.sender == owner, "only contract owner can call this function");
        selfdestruct(owner);
    }

    // require for input validation, will return gas to user
    // assert for checking internal states, will consume all gas
    function receiveMoney() payable public {
        assert(msg.value == uint8(msg.value));
        // a way to check whether the number has overflown
        assert(balanceMap[msg.sender] + uint8(msg.value) >= balanceMap[msg.sender]);
        balanceMap[msg.sender] += uint8(msg.value);
    }

    function withDraw(address payable _to, uint8 _amount) public {
        require(balanceMap[msg.sender] >= _amount, "insufficient balance");
        assert(balanceMap[msg.sender] >= balanceMap[msg.sender] - _amount);
        balanceMap[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // If a function identifier doesn't match any of the available functions in a smart contract. 
    // If there was no data supplied along with the function call.
    fallback() external {
        receiveMoney();
    }
}