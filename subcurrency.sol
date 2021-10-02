pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public minter;
    mapping(address => uint) public balances;
    
    constructor() {
        minter = msg.sender;
    }
    
    event Sent(address from, address to, uint amount);
    
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[minter] += amount;
    }
    
    error insufficientBalance(uint requested, uint available);
    
    function sent(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) 
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
}