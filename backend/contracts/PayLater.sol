// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PayLaterContract {
    struct Agreement {
        address borrower;
        address lender;
        uint256 amount;
        uint256 dueDate;
        uint256 installmentAmount;
        uint256 numInstallments;
        uint256 paidInstallments;
        bool isRepaid;
    }

    mapping(address => Agreement[]) public agreements;
    mapping(address => uint256) public liquidityPool;

    event AgreementCreated(
        address indexed borrower,
        address indexed lender,
        uint256 amount,
        uint256 dueDate,
        uint256 installmentAmount,
        uint256 numInstallments
    );

    event Repayment(
        address indexed borrower,
        uint256 indexed agreementIndex,
        uint256 amount,
        uint256 remainingInstallments
    );

    modifier onlyLiquidityProvider() {
        require(liquidityPool[msg.sender] > 0, "You are not a liquidity provider");
        _;
    }

    function signAgreement(
        address _lender,
        uint256 _amount,
        uint256 _dueDate,
        uint256 _numInstallments
    ) external {
        require(_dueDate > block.timestamp, "Due date must be in the future");
        require(_numInstallments > 0, "Number of installments must be greater than zero");

        uint256 installmentAmount = _amount / _numInstallments;

        agreements[msg.sender].push(Agreement({
            borrower: msg.sender,
            lender: _lender,
            amount: _amount,
            dueDate: _dueDate,
            installmentAmount: installmentAmount,
            numInstallments: _numInstallments,
            paidInstallments: 0,
            isRepaid: false
        }));

        emit AgreementCreated(
            msg.sender,
            _lender,
            _amount,
            _dueDate,
            installmentAmount,
            _numInstallments
        );
    }

    function repay(uint256 _index) external payable {
        require(_index < agreements[msg.sender].length, "Invalid agreement index");
        Agreement storage agreement = agreements[msg.sender][_index];
        require(!agreement.isRepaid, "Agreement already repaid");

        uint256 remainingAmount = agreement.amount - (agreement.installmentAmount * agreement.paidInstallments);
        require(msg.value >= agreement.installmentAmount && msg.value <= remainingAmount, "Invalid payment amount");

        payable(agreement.lender).transfer(msg.value);
        agreement.paidInstallments += 1;

        if (agreement.paidInstallments == agreement.numInstallments) {
            agreement.isRepaid = true;
        }

        uint256 remainingInstallments = agreement.numInstallments - agreement.paidInstallments;

        emit Repayment(
            msg.sender,
            _index,
            msg.value,
            remainingInstallments
        );
    }



    function provideLiquidity() external payable {
        liquidityPool[msg.sender] += msg.value;
    }

    function withdrawLiquidity(uint256 _amount) external onlyLiquidityProvider {
        require(liquidityPool[msg.sender] >= _amount, "Insufficient liquidity");
        liquidityPool[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
