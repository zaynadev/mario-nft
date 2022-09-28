require('@nomiclabs/hardhat-waffle');
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    mumbai: {
      url: process.env.MUMBAI_URL,
      accounts: [ process.env.PRIVATE_KEY ]
    }
  }
};
