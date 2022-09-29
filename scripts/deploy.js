// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
require('dotenv').config();

async function main(){
  const SuperMario = await ethers.getContractFactory("SuperMarioERC1155");
  const superMario = await SuperMario.deploy("SuperMarioOZ", "SUPMC","https://ipfs.io/ipfs/Qmb6tWBDLd9j2oSnvSNhE314WFL7SRpQNtfwjFWsStXp5A/");
  await superMario.deployed();
  console.log("SuperMario contract address: ", superMario.address);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  await superMario.mint(10);
  console.log("NFT Successfully minted");


} 

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
