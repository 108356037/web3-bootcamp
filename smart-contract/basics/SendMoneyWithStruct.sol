// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract SendMoneyStructVer{

    struct Payment {
        uint amount;
        uint timestamps;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping (uint => Payment) paymentsRecord;
    }

    mapping(address => Balance) userBalanceMap;

    function getBalanceOfContract() public view returns(uint){
        return address(this).balance;
    }

    function getUserBalanceAndPaymentsNo() public view returns(uint, uint) {
        return (userBalanceMap[msg.sender].totalBalance, userBalanceMap[msg.sender].numPayments);
    }

    function sendMoney() payable public {
        userBalanceMap[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, block.timestamp);
        uint currentPaymentNo = userBalanceMap[msg.sender].numPayments;

        userBalanceMap[msg.sender].paymentsRecord[currentPaymentNo] = payment;
        userBalanceMap[msg.sender].numPayments++;
    }

    function withdrawAllMoneyTo(address payable _to) public {
        uint transferAmount = userBalanceMap[msg.sender].totalBalance;
        userBalanceMap[msg.sender].totalBalance = 0;
        _to.transfer(transferAmount);
    }

    function withdrawAmountTo(address payable _to, uint _amount) public {
        require(userBalanceMap[msg.sender].totalBalance >= _amount, "insufficient amount in balance");
        userBalanceMap[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

}