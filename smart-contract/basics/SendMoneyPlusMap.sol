// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract AdvancedSendContract {
    
    mapping(address => uint) public FundRecord;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendFund() payable public {
        FundRecord[msg.sender] += msg.value;
    }

    function withDrawAmountTo(address payable _to, uint _amount) public {
        require(FundRecord[msg.sender] >= _amount, "requested amount greater than your balance in contract");
        FundRecord[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function withDrawAllTo(address payable _to) public {
       // CHECK-EFFECTS-INTERACTION Pattern
       // any state modification in the function must happen before an external call is made
       uint amount = FundRecord[msg.sender];
       FundRecord[msg.sender] = 0;
       _to.transfer(amount);
    }


}