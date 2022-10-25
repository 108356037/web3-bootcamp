//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.8;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is Ownable {
    event Transfer(address indexed _from, address indexed _to, uint256 _amount);

    string public constant name = "MyToken";

    uint256 private totalSupply;

    mapping(address => uint256) private balances;

    constructor(uint256 _totalSupply) {
        totalSupply = _totalSupply;
        balances[owner()] += totalSupply;
    }

    function transfer(uint256 _amount, address _to) external {
        require(balances[msg.sender] >= _amount, "insufficient token balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }

    function balanceOf(address _address)
        external
        view
        returns (uint256 result)
    {
        result = balances[_address];
    }

    function getTotalSupply() external view returns (uint256 _totalSupply) {
        _totalSupply = totalSupply;
    }
}
