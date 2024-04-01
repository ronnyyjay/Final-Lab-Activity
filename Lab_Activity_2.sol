// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyFinalsActivity2 {
    address payable public owner;
    uint public constant INITIAL_ETH_AMOUNT = 2 ether;
    uint public remainingEth;
    uint public creationTime;

    event EtherReceived(address sender, uint amount);
    event EtherSent(address recipient, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    constructor() {
        owner = payable(msg.sender);
        creationTime = block.timestamp;
        remainingEth = INITIAL_ETH_AMOUNT;
    }

    receive() external payable {
        remainingEth += msg.value;
        emit EtherReceived(msg.sender, msg.value);
    }

    function receiveandEmit() external payable{
        emit EtherReceived(payable(msg.sender), address(this).balance);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function sendEther(address payable recipient, uint amount) external onlyOwner {
        require(amount <= remainingEth, "Insufficient balance in the contract");
        recipient.transfer(amount);
        remainingEth -= amount;
        emit EtherSent(recipient, amount);
    }

    function destroy() external onlyOwner {
        owner.transfer(remainingEth);
        selfdestruct(owner);
    }
}

//RAMALES, AARON JAY Q.
//WD - 402
