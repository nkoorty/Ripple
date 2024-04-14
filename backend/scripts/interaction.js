
const { ethers } = require("hardhat");

async function signAgreement(contract, lender, amount, dueDate, numInstallments) {
    try {
        const tx = await contract.signAgreement(lender, amount, dueDate, numInstallments);
        await tx.wait();
        console.log('Agreement signed successfully.');
    } catch (error) {
        console.error('Error signing agreement:', error);
    }
}

async function repayInstallment(contract, index, amount) {
    try {
        const tx = await contract.repay(index, { value: amount });
        await tx.wait();
        console.log('Installment repaid successfully.');
    } catch (error) {
        console.error('Error repaying installment:', error);
    }
}

async function provideLiquidity(contract, amount) {
    try {
        const tx = await contract.provideLiquidity({ value: amount });
        await tx.wait();
        console.log('Liquidity provided successfully.');
    } catch (error) {
        console.error('Error providing liquidity:', error);
    }
}

async function withdrawLiquidity(contract, amount) {
    try {
        const tx = await contract.withdrawLiquidity(amount);
        await tx.wait();
        console.log('Liquidity withdrawn successfully.');
    } catch (error) {
        console.error('Error withdrawing liquidity:', error);
    }
}

// Main function to run the script
async function main() {
    const Contract = await ethers.getContractFactory("PayLater");
    const contract = await Contract.attach('0x690A1BBA3753EC440fFcA0201408F6871F92EC17');

    // Call example functions
    await signAgreement(contract, '0x48d3e98336a45A1ddeE1f788FD63D9307368563f', 1000, 1754412800, 4); 
    await repayInstallment(contract, 0, 250);
    await provideLiquidity(contract, 1000); 
    await withdrawLiquidity(contract, 500);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
