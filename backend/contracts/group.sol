// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressBook {
    mapping(string => address) private addresses;
    event AddressSet(string indexed name, address addr);
    function setAddress(string calldata name, address addr) public {
        require(bytes(name).length > 0, "Name cannot be empty");
        require(addr != address(0), "Invalid address");
        
        addresses[name] = addr;
        emit AddressSet(name, addr);
    }
    function getAddress(string calldata name) public view returns (address) {
        require(bytes(name).length > 0, "Name cannot be empty");
        address addr = addresses[name];
        require(addr != address(0), "Address not found");
        
        return addr;
    }
}
