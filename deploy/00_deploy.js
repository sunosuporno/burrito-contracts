require("hardhat-deploy")
require("hardhat-deploy-ethers")

const { networkConfig } = require("../helper-hardhat-config")

const private_key = network.config.accounts[0]
const wallet = new ethers.Wallet(private_key, ethers.provider)

module.exports = async ({ deployments }) => {
    console.log("Wallet Ethereum Address:", wallet.address)
    const chainId = network.config.chainId
    const tokensToBeMinted = networkConfig[chainId]["tokensToBeMinted"]

    //deploy Simplecoin
    const TrustlessRep = await ethers.getContractFactory("TrustlessRep", wallet)
    console.log("Deploying TrustlessRep...")
    const trustlessRep = await TrustlessRep.deploy()
    await trustlessRep.deployed()
    console.log("TrustlessRep deployed to:", trustlessRep.address)

    // //deploy FilecoinMarketConsumer
    // const FilecoinMarketConsumer = await ethers.getContractFactory('FilecoinMarketConsumer', wallet);
    // console.log('Deploying FilecoinMarketConsumer...');
    // const filecoinMarketConsumer = await FilecoinMarketConsumer.deploy();
    // await filecoinMarketConsumer.deployed()
    // console.log('FilecoinMarketConsumer deployed to:', filecoinMarketConsumer.address);

    // //deploy DealRewarder
    // const DealRewarder = await ethers.getContractFactory('DealRewarder', wallet);
    // console.log('Deploying DealRewarder...');
    // const dealRewarder = await DealRewarder.deploy();
    // await dealRewarder.deployed()
    // console.log('DealRewarder deployed to:', dealRewarder.address);
}
