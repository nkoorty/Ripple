// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/Create2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import "Account.sol";

contract AccountFactory {

    Account public immutable accountImplementation;

    constructor(IEntryPoint _entryPoint) {
        accountImplementation = new Account(_entryPoint);
    }

    function createAccount(address owner, uint256 salt) public returns (Account ret) {
        // calculate address
        address addr = getAddress(owner, salt);
        // check address
        uint codeSize = addr.code.length;
        if (codeSize > 0) {
            return Account(payable(addr));
        }
        ret = Account(payable(new ERC1967Proxy{salt : bytes32(salt)}(
                address(accountImplementation),
                abi.encodeCall(Account.initialize, (owner))
            )));
        return ret; 
    }

    function getAddress(address owner, uint256 salt) public view returns (address) {
        return Create2.computeAddress(bytes32(salt), keccak256(abi.encodePacked(
                type(ERC1967Proxy).creationCode,  
                abi.encode( 
                    address(accountImplementation),
                    abi.encodeCall(Account.initialize, (owner))
                )
            )));
    }
}
