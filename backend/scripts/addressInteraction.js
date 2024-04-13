// Import ethers from Hardhat package
const { ethers } = require("hardhat");

async function main() {
    // The address of the deployed AddressBook contract
    const contractAddress = "0x82d4a7001Dd397B443643730120Cb8bA8c45a073";

    // Get the Contract instance attached to the deployed contract address
    const AddressBook = await ethers.getContractFactory("AddressBook");
    const addressBook = AddressBook.attach(contractAddress);

    // Example names and their corresponding addresses
    const names = ["Alice", "Bob", "Charlie"];
    const exampleAddresses = [
        "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", // Use valid addresses
        "0xbe0eb53f46cd790cd13851d5eff43d12404d33e8",
        "0xa0ee7a142d267c1f36714e4a8f75612f20a79720"
    ];

    // Sequentially set addresses for names
    console.log(`Setting addresses for names sequentially...`);
    for (let i = 0; i < names.length; i++) {
        console.log(`Setting address for ${names[i]}...`);
        const tx = await addressBook.setAddress(names[i], exampleAddresses[i]);
        await tx.wait();
        console.log(`Address set for ${names[i]}: ${exampleAddresses[i]}`);
    }

    // Sequentially get and print addresses for names
    console.log(`Fetching addresses for names sequentially...`);
    for (let i = 0; i < names.length; i++) {
        console.log(`Fetching address for ${names[i]}...`);
        const retrievedAddress = await addressBook.getAddress(names[i]);
        console.log(`Address retrieved for ${names[i]}: ${retrievedAddress}`);
    }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
