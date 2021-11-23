// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves = 0;

    // look up events in Solidity
    event NewWave(address indexed from, uint256 timestamp, string message);

    mapping(address => uint) public userWaves;

    struct Wave {
        address waver; // address of user who sent the wave
        string message; // the message
        uint timestamp; // when the wave was sent
    }

    Wave[] waves; // array of the waves to store them in

    constructor() {
        console.log("gm y'all");
    }

    function wave(string memory _message) public {
        totalWaves++;
        userWaves[msg.sender]++;

        waves.push(Wave(msg.sender, _message, block.timestamp));

        // look this up (emit keyword in solidity)
        emit NewWave(msg.sender, block.timestamp, _message);

        console.log('%s has waved!',msg.sender);
        console.log('This is their %d wave to date.', userWaves[msg.sender]);
    }

    // getter function for the waves struct array
    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    // contract prints the total waves
    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waves!', totalWaves);
        return totalWaves;
    }

}