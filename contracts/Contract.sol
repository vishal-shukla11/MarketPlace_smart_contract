// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenContract {
    address public owner;
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    function transfer(address _to, uint256 _amount) public onlyOwner {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        require(_to != address(0), "Invalid address");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "Invalid address");
        balances[_to] += _amount;
    }

    
    function balanceOf(address _account) public view returns (uint256) {
        return balances[_account];
    }
}
