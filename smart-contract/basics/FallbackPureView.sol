// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract ExceptionExample {

    mapping(address => uint) public balanceMap;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function destroyContract() public {
        require(msg.sender == owner, "only contract owner can call this function");
        selfdestruct(owner);
    }

    // a view function can only READ storage variable(e.g. attributes of a class) in a contract
    // a view function can also call a pure function
    function getOwner() public view returns(address) {
        return owner;
    }

    // pure function doesn't interact with any storage variable
    // pure func can call other pure func but not view func
    function returnInEther(uint _amountInWei) public pure returns(uint) {
        return _amountInWei / 1 ether;
    }

    // require for input validation, will return gas to user
    // assert for checking internal states, will consume all gas
    function receiveMoney() payable public {
        assert(msg.value == uint(msg.value));
        // a way to check whether the number has overflown
        assert(balanceMap[msg.sender] + uint(msg.value) >= balanceMap[msg.sender]);
        balanceMap[msg.sender] += uint(msg.value);
    }

    function withDraw(address payable _to, uint _amount) public {
        require(balanceMap[msg.sender] >= _amount, "insufficient balance");
        assert(balanceMap[msg.sender] >= balanceMap[msg.sender] - _amount);
        balanceMap[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    // If a function identifier doesn't match any of the available functions in a smart contract. 
    // If there was no data supplied along with the function call.


    //new fallback function is called when no other function matches 
    // (if the receive ether function does not exist then this includes calls with empty call data). 
    fallback() external {
        getOwner();
    }

    // the receive ether function is called whenever the call data is empty (whether or not ether is received)
    // must be payable
    receive() external payable{
        receiveMoney();
    }
}