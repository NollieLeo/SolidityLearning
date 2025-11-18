// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FundToken {
    // 1. 通证名称
    // 2. 简称
    // 3. 发行数量
    // 4. owenr地址
    // 5. balance address => uint256

    string public tokenName;
    string public tokenSymbol;

    uint256 public totalSupply;
    address public owner;
    mapping(address => uint256) public balances;

    constructor(string memory _tokenName, string memory _tokenSymbol) {
        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        owner = msg.sender;
    }

    // 获取通证
    function mint(uint256 amountToMint) public {
        balances[msg.sender] += amountToMint;
        totalSupply += totalSupply;
    }

    // transfer 通证数量
    function transfer(address payee, uint256 amount) public {
        require(balances[msg.sender] >= amount, "You do not have enough token");
        balances[msg.sender] -= amount;
        balances[payee] += amount;
    }

    // balanceof 获取某个地址下的token
    function balanceof(address account) public view returns (uint256) {
        return balances[account];
    }
}
