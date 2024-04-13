require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    xrplsidechain: {
      url: "https://rpc-evm-sidechain.xrpl.org",
      chainId: 1440002,
      accounts: ['4de90b65c00873ca0ce43a55c9b0a3c31b32c05d55a7df56bfa0cacd5afa8f98'],
    }
  }
};
