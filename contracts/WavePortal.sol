// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves = 0;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    // look up events in Solidity
    event NewWave(address indexed from, uint256 timestamp, string message);

    mapping(address => uint) public userWaves;
    mapping(address => uint) public lastWavedAt;

    struct Wave {
        address waver; // address of user who sent the wave
        string message; // the message
        uint timestamp; // when the wave was sent
    }

    Wave[] waves; // array of the waves to store them in

    constructor() payable {
        console.log("gm y'all, we're constructed");
         /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 60 seconds < block.timestamp,
            "Only 1 wave allowed per minute."
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves++;
        userWaves[msg.sender]++;

        waves.push(Wave(msg.sender, _message, block.timestamp));
        console.log('%s has waved!',msg.sender);
        console.log('This is their %d wave to date.', userWaves[msg.sender]);

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }
        // look this up (emit keyword in solidity)
        emit NewWave(msg.sender, block.timestamp, _message);

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