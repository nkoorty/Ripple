# RipSplit

<p align="center">
  <img src="https://github.com/nkoorty/Ripple/assets/22000925/453c4648-7969-4ad5-93f6-d6c9ecf8e8ac" width="25%">
</p>


Ripsplit is an iOS dApp built on the XRP EVM sidechain. It simplifies the process of splitting expenses and settling payments by using account abstraction and uses smart contracts to facilitate group management in a trustless and decentralised manner.

<p align="center">
  [ADD IMAGES]
</p>

# Problem Statement

RipSplit is a mobile app designed to change how groups manage and settle expenses. As the expense splitting market is expected to grow to half a [billion dollars by 2031](https://www.businessresearchinsights.com/market-reports/bill-splitting-apps-market-100395#:~:text=The%20global%20bill%20splitting%20apps,of%20splitting%20the%20expenses%20easy.), existing solutions fall short, lacking efficient, decentralised payment methods. This often results in complex and error-prone processes, especially in activities like travel, dining, or shared living, where managing expenses can require tedious manual tracking and constant follow-ups for repayments. Similar apps suffer with real time tracking, challenges in dealing with multiple currencies, and reliance on one individual to manage all records, leading to potential delays and disputes. Moreover, traditional apps tend to rely on centralised payment systems like banks or PayPal, which can limit flexibility and transparency.

RipSplit addresses these issues by facilitating direct, in-app settlements using the XRP EVM sidechain, significantly simplifying the management of shared expenses while enhancing security and flexibility. This approach ensures a smoother, more reliable and versatile experience in handling group finances, directly within the app.

# Workflow:

<p align="center">
  [Workflow Diagram]
  https://www.figma.com/file/500rAeOuPjuVdLkSwBZSnf/Untitled?type=design&node-id=0-1&mode=design&t=BUVHnmrbzX5Mf3Jv-0
</p>


- The user can either connect an account using metamask or create a new account using smart accounts through account abstraction and Web3Auth as a non-custodial way of storing private keys.
- The user can fund their account using the Unlimit iOS SDK onramp.
- Once logged in the user is directed to the home page and can create groups or settle outgoing expenses.
- To create a group the user adds the details of the friends they want to settle the expense with (name, address, amount), and the friends are notified with the details. The group expense managment is handled by the `Group.sol` contract.
- To settle an expense users with smart accounts can sign one transaction that will batch settle all outgoing settlements. Or users can manually sign transactions for each group.
- FaceID is used to authenticate the transaction with turnkey used to generate a signer key. 
- Users can also shake their phone to activate authentication of settling expenses.
- Payments are handled using the `Account.sol` contract and funds can be off-ramped into fiat to the user.


# Technical Documentation
#### Account.sol: [0x70DF87FD59799c4e62829f066D4C59d08e56948f](https://evm-sidechain.xrpl.org/address/0x70DF87FD59799c4e62829f066D4C59d08e56948f)
Is the smart contract for the EIP 4337 smart accounts that incorporate account abstraction with features such as upgradability, initialisation and session management for multiple users. The contract allows for secure owner-only operations like withdrawals and updates and facilitates execution of both individual and batch transactions. It also logs activities through events for traceability. 

- `execute` - executes a single transaction to a specified destination with a given amount.
- `executeBatch` - executes multiple transactions in a batch to different destinations with specified amount.
#### AccountFactory.sol: [0xE08B3A7e9813d1c1781Bc1e8176bf13d0a5BfA50](https://evm-sidechain.xrpl.org/address/0xE08B3A7e9813d1c1781Bc1e8176bf13d0a5BfA50?tab=txs)
The account factory contract uses `Create2` and `ERC1967Proxy` features from OpenZeppelin to facilitate the creation and management of upgradable `Account` instances. The factory uses an immutable template of the `Account` contract, initialised with a specific entry point, to deploy new account instances with unique salts and owner addresses. 

#### Group.sol [0xEF63F82bE58DCfb96342E04DB0e553bA715de2Aa](https://evm-sidechain.xrpl.org/address/0xEF63F82bE58DCfb96342E04DB0e553bA715de2Aa)
This contract manages the settlement groups and maps users names to smart account or wallet addresses. Function calls are used to display the information in app and are called in payment transactions. 




# Future
- Automated actions and workflows of the smart accounts (conditional payments, scheduled payments, automatic adjustment for currency fluctuations etc).
- Add liquidity pool and option to take out small loans and delegate credit to other users.

# Team
- [Artemiy Malyshau](https://www.linkedin.com/in/artemiy-malyshau/): Frontend Engineer
- [Christian Grinling](https://www.linkedin.com/in/christian-grinling/): Frontend Engineer
- [Jeevan Jutla](https://www.linkedin.com/in/jeevan-jutla/): Backend Engineer
- [Adesh Dooraree](https://www.linkedin.com/in/adeshdooraree/): Backend Engineer

 ![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white)
 ![Javascript](https://shields.io/badge/JavaScript-F7DF1E?logo=JavaScript&logoColor=000&style=flat-square)
 ![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
