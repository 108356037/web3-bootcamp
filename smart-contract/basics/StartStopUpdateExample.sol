// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract StartStopUpdate {
    
    address owner;
    bool public paused;

    constructor() {
       owner = msg.sender;
       paused = false;
    }

    function sendMoney() public payable {
    
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "only contract owner can call this function");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "only contract owner can call this function");
        require(!paused, "this contract is currently paused, wait for owner to restart it");
        _to.transfer(address(this).balance);
    }

    function destroyContract(address payable _to) public {
        require(msg.sender == owner, "only contract owner can call this function");
        
        // if selfdestruct called, it will send all remaining balance to the given address
        selfdestruct(_to);
    }
}