// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    mapping(address => uint) public userWaves;

    constructor() {
        console.log("gm y'all");
    }

    function wave() public {
        totalWaves++;
        userWaves[msg.sender]++;
        console.log('%s has waved!',msg.sender);
        console.log('This is their %d wave to date.', userWaves[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waves!', totalWaves);
        return totalWaves;
    }

}