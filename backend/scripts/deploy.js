const { ethers } = require("hardhat");

async function main() {
  // Compile the contract
  const PayLaterContract = await ethers.getContractFactory("PayLaterContract");

  // Deploy the contract
  console.log("Deploying PayLaterContract...");
  const payLaterContract = await PayLaterContract.deploy();

  console.log("PayLaterContract deployed to:", payLaterContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
