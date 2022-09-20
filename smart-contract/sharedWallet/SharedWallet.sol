// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

import "./BasicWallet.sol";
import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/math/SafeMath.sol";


interface WalletStructs {
    // struct Deposit {
    //     address from;
    //     uint amount;
    //     uint depositTime;
    // }

    struct SubAccountDetail {
        uint depositedAmount;
        uint allowance;
    }

}


contract SharedWallet is BasicWallet {
    
    using SafeMath for uint;

    //uint public depositNum;
    //mapping(uint => WalletStructs.Deposit) public depositRecord;
    
    mapping(address => WalletStructs.SubAccountDetail) public subAccount;

    event DepositEvent(address indexed _from, uint _amount, uint _timestamp);
    event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);

    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || subAccount[msg.sender].allowance >= _amount, "you are not allowed");
        _;
    }

    function getUserAllowance(address _user) public view returns(uint) {
        return subAccount[_user].allowance;
    }

    function getUserDepositedAmount(address _user) public view returns(uint) {
        return subAccount[_user].depositedAmount;
    }

    function setUserAllowance(address _forWho, uint _amount) public unFreezed onlyOwner {
        require(_amount <= this.totalBalance(), "cannot approve balance larger than whole wallet");
        //require(_amount >= subAccount[_user].depositedAmount, "cannot set amount smaller than user have deposited");
        
        emit AllowanceChanged(_forWho, msg.sender, subAccount[_forWho].allowance, _amount);
        subAccount[_forWho].allowance = _amount;   
    }

    function reduceAllowance(address _forWho, uint _amount) internal ownerOrAllowed(_amount){
        emit AllowanceChanged(_forWho, msg.sender, subAccount[_forWho].allowance, subAccount[_forWho].allowance.sub(_amount));
        subAccount[_forWho].allowance = subAccount[_forWho].allowance.sub(_amount);
    }

    function withdrawMoney(address payable _to, uint _amount) public unFreezed ownerOrAllowed(_amount){
        require(address(this).balance >= _amount, "Contract doesn't have enough balance.");
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override view onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
        subAccount[msg.sender].depositedAmount = subAccount[msg.sender].depositedAmount.add(msg.value);
    }

    // function userDeposit() public payable unFreezed {

    //     // issue: can only deposit uint256.max times
    //     assert(depositNum.add(1) > depositNum);
    //     assert(subAccount[msg.sender].depositedAmount.add(msg.value) >= subAccount[msg.sender].depositedAmount);

    //     uint timestamp = block.timestamp;
    //     WalletStructs.Deposit memory deposit = WalletStructs.Deposit(msg.sender, msg.value, timestamp);
    //     depositRecord[depositNum] = deposit;
    //     depositNum = depositNum.add(1);

    //     emit DepositEvent(msg.sender, msg.value, timestamp);

    //     subAccount[msg.sender].depositedAmount = subAccount[msg.sender].depositedAmount.add(msg.value);
    // }
}