// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TrustFund {
    struct Beneficiary {
        uint amount;
        uint maturity;
        bool paid;
    }

    mapping(address => Beneficiary) public beneficiaries;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function addBeneficiary(address beneficiary, uint timeToMaturity) external payable {
        require(msg.sender == admin, 'Only admin can add beneficiary!');
        require(beneficiaries[beneficiary].amount == 0, 'Beneficiary already exists!');
        beneficiaries[beneficiary] = Beneficiary(msg.value, block.timestamp + timeToMaturity, false);
    }

    function withdraw() external {
        Beneficiary storage beneficiary = beneficiaries[msg.sender];
        require(beneficiary.maturity >= block.timestamp, 'Too early to withdraw!');
        require(beneficiary.amount > 0, 'Only beneficiary can withdraw!');
        require(beneficiary.paid == false, 'Already withdrawn!');
        beneficiary.paid = true;
        payable(msg.sender).transfer(beneficiary.amount);
    }
} 
