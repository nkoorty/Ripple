require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.23",
  networks: {
    xrplsidechain: {
      url: "https://rpc-evm-sidechain.xrpl.org",
      chainId: 1440002,
      accounts: ['fc8525a135d9acc5c747fd2ce395fa0593dfd402b4fe7ace4ca1994b74c46b63'],
    }
  }
};
