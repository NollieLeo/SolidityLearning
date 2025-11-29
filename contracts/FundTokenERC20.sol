// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";

// 1. 让FundMe的参与者，基于mapping领取相对应数量的token
// 2.
contract Motherfucker is ERC20 {
    FundMe fundMe;
    constructor(address fundMeAddr) ERC20("Motherfucker", "MF") {
        fundMe = FundMe(fundMeAddr);
    }

    function mint(uint256 amount) public {
        uint256 fundMeAmount = fundMe.fundersToAmount(msg.sender);
        require(fundMeAmount >= amount, "You need more fund");
        _mint(msg.sender, amount);
        fundMe.setFunderToAmount(msg.sender, fundMeAmount - amount);
    }

    function claim(uint256 amountToClam) public {
        require(
            balanceOf(msg.sender) >= amountToClam,
            "You have no enough ERC20 tokens"
        );
        // Todo
        // claim 完之后需要burn掉
        _burn(msg.sender, amountToClam);
    }

    modifier IsFundMeGetFundSuccess() {
        require(fundMe.getFundSuccess(), "FundMe is not completed");
        _;
    }
}
