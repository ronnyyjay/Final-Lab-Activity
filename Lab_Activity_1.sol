// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EtherWallet {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "Owner Only!.");
        require(_amount <= address(this).balance, "Balance Low.");
        owner.transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

//RAMALES, AARON JAY Q.
//WD - 402
