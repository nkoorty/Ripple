// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "./contracts/proxy/utils/UUPSUpgradeable.sol";
import "@account-abstraction/contracts/core/BaseAccount.sol";
import "@account-abstraction/contracts/samples/callback/TokenCallbackHandler.sol";
import "./SessionManager.sol";


contract Account is BaseAccount, TokenCallbackHandler, UUPSUpgradeable, Initializable, SessionManager {
    using ECDSA for bytes32; 
    address public owner; 
    IEntryPoint private immutable _entryPoint; 

    // events for logging 
    event SimpleAccountInitialized(IEntryPoint indexed entryPoint, address indexed owner);
    event Invoked(address indexed target, uint256 value, bytes data);
    event BatchInvoked(address[] target, uint256 value, bytes[] data);

    // restrict function access to the owner of the contract
    modifier onlyOwner() {
        _onlyOwner();
        _;
    }

    function entryPoint() public view virtual override returns (IEntryPoint) {
        return _entryPoint;
    }

    // receive transfers directly to the contract
    receive() external payable {}

    // entrypoint 
    constructor(IEntryPoint anEntryPoint) {
        _entryPoint = anEntryPoint;
        _disableInitializers();  
    }

    // check if the caller is the owner
    function _onlyOwner() internal view {
        require(msg.sender == owner || msg.sender == address(this), "only owner");
    }

    // execute a transaction with details
    function execute(address dest, uint256 value, bytes calldata func) external {
        bool isSession = _requireFromEntryPointOrOwnerOrSessionOwner(value);
        _call(dest, value, func);
        if (isSession) _increaseSpent(msg.sender, value);
        emit Invoked(dest, value, func);
    }

    // execute a batch of transactions 
    function executeBatch(address[] calldata dest, uint256[] calldata value, bytes[] calldata func) external {
        uint256 totalAmountSpent = 0;
        if (value.length == 0) { 
            for (uint256 i = 0; i < dest.length; i++) {
                totalAmountSpent += value[i];
            }
        }
        bool isSession = _requireFromEntryPointOrOwnerOrSessionOwner(totalAmountSpent);
        require(dest.length == func.length && (value.length == 0 || value.length == func.length), "wrong array lengths");
        if (value.length == 0) {
            for (uint256 i = 0; i < dest.length; i++) {
                _call(dest[i], 0, func[i]);
            }
        } else {
            for (uint256 i = 0; i < dest.length; i++) {
                _call(dest[i], value[i], func[i]);
            }
        }
        if (isSession) _increaseSpent(msg.sender, totalAmountSpent);
        emit BatchInvoked(dest, totalAmountSpent, func);
    }

    function addSession(address sessionUser, uint256 startFrom, uint256 validUntil, uint256 totalAmount) external {
        _requireFromEntryPointOrOwner();
        _addSession(sessionUser, startFrom, validUntil, totalAmount);
    }

    function removeSession(address sessionUser) external {
        _requireFromEntryPointOrOwner();
        _removeSession(sessionUser);
    }

    function initialize(address anOwner) public virtual initializer {
        _initialize(anOwner);
    }

    function _initialize(address anOwner) internal virtual {
        owner = anOwner;
        emit SimpleAccountInitialized(_entryPoint, owner);
    }

    function _requireFromEntryPointOrOwner() internal view {
        require(msg.sender == address(entryPoint()) || msg.sender == owner, "account: not Owner or EntryPoint");
    }

    function _requireFromEntryPointOrOwnerOrSessionOwner(uint256 amount) internal view returns (bool isSession) {
        if (msg.sender == address(entryPoint()) || msg.sender == owner) return false;
        require(
            (
                sessions[msg.sender].startFrom < block.timestamp && sessions[msg.sender].validUntil > block.timestamp
                    && sessions[msg.sender].spentAmount + amount <= sessions[msg.sender].totalAmount
            ),
            "account: not Owner or EntryPoint or Session user"
        );
        return true;
    }

    // signature validation 
    function _validateSignature(UserOperation calldata userOp, bytes32 userOpHash)
        internal
        virtual
        override
        returns (uint256 validationData)
    {
        bytes32 hash = userOpHash.toEthSignedMessageHash();
        if (userOp.signature.length == 65) {
            if (owner == hash.recover(userOp.signature)) return 0;
            else return SIG_VALIDATION_FAILED;
        }
        address sessionUser = address(bytes20(userOp.signature[0:20]));
        bytes memory sessionSignature = userOp.signature[20:];
        Session memory session = sessions[sessionUser];
        if (sessionUser != hash.recover(sessionSignature)) return SIG_VALIDATION_FAILED;
        if (session.startFrom > block.timestamp || session.validUntil < block.timestamp) return SIG_VALIDATION_FAILED;
        return 0;
    }

    function getDeposit() public view returns (uint256) {
        return entryPoint().balanceOf(address(this));
    }

    function addDeposit() public payable {
        entryPoint().depositTo{value: msg.value}(address(this));
    }

    function withdrawDepositTo(address payable withdrawAddress, uint256 amount) public onlyOwner {
        entryPoint().withdrawTo(withdrawAddress, amount);
    }

    function _authorizeUpgrade(address newImplementation) internal view override {
        (newImplementation);
        _onlyOwner();
    }
}
