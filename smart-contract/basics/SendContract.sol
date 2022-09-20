// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract SendMoneyExample {
    
    uint public balanceReceived;
    uint public lockedUntil;

    // payable keyword to enable receiving ethers  
    function receiveMoney() payable public {
        balanceReceived += msg.value;
        lockedUntil = block.timestamp + 1 minutes;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withDrawMoney() public {
        if (lockedUntil < block.timestamp) {
            address payable to = payable(msg.sender);
            // it is the "to" address that actually gets ether 
            to.transfer(this.getBalance());
        }
        
    }

    function withDrawMoneyTo(address payable _to) public {
        if (lockedUntil < block.timestamp) {
            _to.transfer(this.getBalance());
        }
    }
}