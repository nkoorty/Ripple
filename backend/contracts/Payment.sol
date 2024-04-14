// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

contract TransactionManager {
    address public owner;
    mapping(address => Session) public sessions;

    struct Session {
        uint256 startFrom;
        uint256 validUntil;
        uint256 totalAmount;
        uint256 spentAmount;
    }

    event Invoked(address indexed target, uint256 value, bytes data);
    event BatchInvoked(address[] target, uint256 totalAmountSpent, bytes[] data);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "TransactionManager: Caller is not the owner");
        _;
    }

    function _call(address target, uint256 value, bytes memory data) internal {
        (bool success, ) = target.call{value: value}(data);
        require(success, "TransactionManager: Call failed");
    }

    function _requireFromEntryPointOrOwnerOrSessionOwner(uint256 amount) internal view returns (bool isSession) {
        if (msg.sender == owner) {
            return false;
        }

        Session storage session = sessions[msg.sender];
        require(
            block.timestamp >= session.startFrom && block.timestamp <= session.validUntil,
            "TransactionManager: Session is not active"
        );
        require(
            session.spentAmount + amount <= session.totalAmount,
            "TransactionManager: Session spending limit exceeded"
        );

        return true;
    }

    function _increaseSpent(address sessionUser, uint256 amount) internal {
        Session storage session = sessions[sessionUser];
        session.spentAmount += amount;
    }

    // execute a transaction with details
    function execute(address dest, uint256 value, bytes calldata func) external {
        bool isSession = _requireFromEntryPointOrOwnerOrSessionOwner(value);
        _call(dest, value, func);
        if (isSession) {
            _increaseSpent(msg.sender, value);
        }
        emit Invoked(dest, value, func);
    }

    // execute a batch of transactions
    function executeBatch(address[] calldata dest, uint256[] calldata value, bytes[] calldata func) external {
        uint256 totalAmountSpent = 0;
        for (uint256 i = 0; i < dest.length; i++) {
            totalAmountSpent += value[i];
        }

        bool isSession = _requireFromEntryPointOrOwnerOrSessionOwner(totalAmountSpent);
        require(dest.length == func.length, "TransactionManager: Array lengths must match");

        for (uint256 i = 0; i < dest.length; i++) {
            uint256 transactionValue = value.length == 0 ? 0 : value[i];
            _call(dest[i], transactionValue, func[i]);
        }

        if (isSession) {
            _increaseSpent(msg.sender, totalAmountSpent);
        }

        emit BatchInvoked(dest, totalAmountSpent, func);
    }
}
