// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingVault {

    IERC20 public token;

    mapping(address => uint256) public staked;

    uint256 public rewardRate = 10;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function stake(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
        staked[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(staked[msg.sender] >= amount, "not enough balance");

        staked[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
    }

    function reward(address user) public view returns (uint256) {
        return (staked[user] * rewardRate) / 100;
    }
}
