const ethers = require('ethers');

// Contract address and ABI
const contractAddress = '0x690A1BBA3753EC440fFcA0201408F6871F92EC17';
const contractABI = [
    // Paste the contract ABI here
];

// Ethereum node connection
const provider = new ethers.providers.JsonRpcProvider('YOUR_ETH_NODE_URL');
const signer = provider.getSigner();

// Contract instance
const contract = new ethers.Contract(contractAddress, contractABI, signer);

// Example function to sign an agreement
async function signAgreement(lender, amount, dueDate, numInstallments) {
    try {
        const tx = await contract.signAgreement(lender, amount, dueDate, numInstallments);
        await tx.wait();
        console.log('Agreement signed successfully.');
    } catch (error) {
        console.error('Error signing agreement:', error);
    }
}

// Example function to repay an installment
async function repayInstallment(index, amount) {
    try {
        const tx = await contract.repay(index, { value: amount });
        await tx.wait();
        console.log('Installment repaid successfully.');
    } catch (error) {
        console.error('Error repaying installment:', error);
    }
}

// Example function to provide liquidity
async function provideLiquidity(amount) {
    try {
        const tx = await contract.provideLiquidity({ value: amount });
        await tx.wait();
        console.log('Liquidity provided successfully.');
    } catch (error) {
        console.error('Error providing liquidity:', error);
    }
}

// Example function to withdraw liquidity
async function withdrawLiquidity(amount) {
    try {
        const tx = await contract.withdrawLiquidity(amount);
        await tx.wait();
        console.log('Liquidity withdrawn successfully.');
    } catch (error) {
        console.error('Error withdrawing liquidity:', error);
    }
}

// Call example functions
signAgreement('LENDER_ADDRESS', 1000, 1754412800, 4); // Example parameters
repayInstallment(0, 250); // Example parameters
provideLiquidity(1000); // Example parameters
withdrawLiquidity(500); // Example parameters
