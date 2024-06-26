const { ethers } = require("hardhat");

async function main() {
    const contractAddress = "0x82d4a7001Dd397B443643730120Cb8bA8c45a073";

    const AddressBook = await ethers.getContractFactory("AddressBook");
    const addressBook = AddressBook.attach(contractAddress);

    const names = ["Adesh", "Christian", "Artemiy"];
    const exampleAddresses = [
        "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", 
        "0xbe0eb53f46cd790cd13851d5eff43d12404d33e8",
        "0xa0ee7a142d267c1f36714e4a8f75612f20a79720"
    ];

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

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
