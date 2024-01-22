pragma solidity ^0.8.22;

contract First {
    address public owner;
    mapping(address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor(){
        owner = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == owner);
        balances[receiver] += amount;
    }

    error insufficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

}
