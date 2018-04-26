/*
 * TokenStorageLib
 *
 * Copyright © 2018 by NewCryptoBlock.
 *
 * Based on Smart Contract Token System by Monerium
 * https://github.com/monerium/smart-contracts
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).
 */
pragma solidity ^0.4.11;

import "./SafeMathLib.sol";

library TokenStorageLib {
    using SafeMathLib for uint256;

    struct Storage {
        mapping (address => uint256) balances;
        mapping (address => mapping (address => uint256)) allowed;
        uint256 totalSupply;
        uint256 capAmount;
    }

    // EXTERNAL
     /**
     * @dev addBalance
     *
     * @param _to to which account
     * @param _amount Number of approved tokens.
     */
    function addBalance(Storage storage self, address _to, uint256 _amount) {
        var newTotalSupply = self.totalSupply.plus(_amount);
        require(newTotalSupply <= self.capAmount);
        self.totalSupply = newTotalSupply;
        self.balances[_to] = self.balances[_to].plus(_amount);
    }

    /**
     * @dev subBalance
     *
     * @param _from from which account.
     * @param _amount Number of approved tokens.
     */
    function subBalance(Storage storage self, address _from, uint256 _amount) {
        self.totalSupply = self.totalSupply.minus(_amount);
        self.balances[_from] = self.balances[_from].minus(_amount);
    }
    /**
     * @dev setAllowed
     *
     * @param _owner Address of allowed account.
     * @param _spender Address of allowed account.
     * @param _amount Number of approved tokens.
     */
    function setAllowed(Storage storage self, address _owner, address _spender, uint256 _amount) {
        self.allowed[_owner][_spender] = _amount;
    }

    /**
     * @dev Function to increase tokens cap amount
     * @param _amount The amount of tokens to increase the cap.
     * @return A boolean that indicates if the operation was successful.
     */
    function increaseCap(Storage storage self, uint256 _amount) {
        self.capAmount = self.capAmount.plus(_amount);
    }

    /**
     * @dev Function to decrease tokens cap amount
     * @param _amount The amount of tokens to decrease the cap.
     * @return A boolean that indicates if the operation was successful.
     */
    function decreaseCap(Storage storage self, uint256 _amount) {
        self.capAmount = self.capAmount.minus(_amount);
    }

    // EXTERNAL CONSTANT
    /**
     * @dev getSupply
     *
     * return the amount of available supply
     */
    function getSupply(Storage storage self) constant returns (uint256) {
        return self.totalSupply;
    }

    /**
     * @dev getCap
     *
     * return the token cap amount
     */
    function getCap(Storage storage self) constant returns (uint256) {
        return self.capAmount;
    }

    /**
     * @dev getBalance - returns the balance of the specified account
     *
     * @param _who Address of the account.
     */
    function getBalance(Storage storage self, address _who) constant returns (uint256) {
        return self.balances[_who];
    }

    /**
     * @dev getAllowed - returns the allowed amount
     *
     * @param _owner Address of allowed account.
     * @param _spender Address of allowed account.
     */
    function getAllowed(Storage storage self, address _owner, address _spender) constant returns (uint256) {
        return self.allowed[_owner][_spender];
    }
}
