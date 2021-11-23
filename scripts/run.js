const { hexStripZeros } = require("@ethersproject/bytes")

const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log('Contract deployed to: ', waveContract.address);
    console.log('Contract deployed by: ', owner.address);

    let waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave('Message 1');
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave('A second message!');
    await waveTxn.wait();
    waveTxn = await waveContract.connect(randomPerson).wave('Third time is 3 charms.');
    await waveTxn.wait();
  
    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves)
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

runMain();