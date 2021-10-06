//SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

import "./RWD.sol";
import "./Tether.sol";

contract DecentralBank {
    string public name = "Decentral Bank";
    address public owner;
    Tether public tether;
    RWD public rwd;

    address[] public stakers;

    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaked;

    constructor(RWD _rwd, Tether _tether) public {
        rwd = _rwd;
        tether = _tether;
    }

    function depositTokens(uint256 _amount) public {
        require(_amount > 0, "Amount cannot be 0");
        tether.transferFrom(msg.sender, address(this), _amount);

        stakingBalance[msg.sender] += _amount;

        if (!hasStaked) {
            stakers.push(msg.sender);
        }
        hasStaked[msg.sender] = true;
        isStaked[msg.sender] = true;
    }
}
