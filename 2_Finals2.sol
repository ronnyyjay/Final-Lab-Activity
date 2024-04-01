// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract SendEther{
    constructor() payable {}

    receive() external payable{}

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(100);
    }

    function sendViaSend(address payable _to) external payable{
        bool sent = _to.send(100);
        require(sent, "Sending Failed.");
    }

    function sendViaCall(address payable _to) external payable{
        (bool success, ) = _to.call{value:100}("");
        require(success, "Call Failed.");
    }

}

contract ReceiveEther{
    event Log(uint amount, uint gas);

    receive() external payable{
        emit Log(msg.value, gasleft());
    }
}

contract SelfDestruct{
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner = msg.sender;

    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() external{
        require(msg.sender == owner, "Not Owner!");
        emit Withdraw((address(this).balance));
        selfdestruct(payable(msg.sender));
    }
}

//RAMALES, AARON JAY Q.
//WD - 402
