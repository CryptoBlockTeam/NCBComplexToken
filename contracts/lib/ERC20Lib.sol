/*
 * ERC20Lib - ERC20 standard implementation
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
import "../helper/TokenRecipient.sol";
import "../controller/TokenStorage.sol";

library ERC20Lib {
    using SafeMathLib for uint;

    // EVENTS
   /**
    * @dev Logged when tokens were transferred from one owner to another.
    *
    * @param _from address of the owner, tokens were transferred from
    * @param _to address of the owner, tokens were transferred to
    * @param _value number of tokens transferred
    */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

   /**
    * @dev Logged when owner approved his tokens to be transferred by some spender.
    *
    * @param _owner owner who approved his tokens to be transferred
    * @param _spender spender who were allowed to transfer the tokens belonging
    *        to the owner
    * @param _value number of tokens belonging to the owner, approved to be
    *        transferred by the spender
    */
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // EXTERNAL
    /**
     * @dev Transfer given number of tokens from message sender to given recipient.
     *
     * @param db token storage
     * @param _caller address
     * @param _to address to transfer tokens to the owner of
     * @param _value number of tokens to transfer to the owner of given address
     * @return true if tokens were transferred successfully, false otherwise
     */
    function transfer(TokenStorage db, address _caller, address _to, uint256 _value) returns (bool) {
        db.subBalance(_caller, _value);
        db.addBalance(_to, _value);
        Transfer(_caller, address(db), _value);
        return true;
    }

    /**
     * @dev Transfer given number of tokens from given owner to given recipient.
     *
     * @param db storage
     * @param _caller address
     * @param _from address to transfer tokens from the owner of
     * @param _to address to transfer tokens to the owner of
     * @param _value number of tokens to transfer from given owner to given
     *         recipient
     * @return true if tokens were transferred successfully, false otherwise
     */
    function transferFrom(TokenStorage db, address _caller, address _from, address _to, uint256 _value) returns (bool success) {
        var allowance = db.getAllowed(_from, _caller);
        db.subBalance(_from, _value);
        db.addBalance(_to, _value);
        db.setAllowed(_from, _caller, allowance.minus(_value));
        Transfer(_from, _to, _value);
        return true;
    }

    /**
     * @dev Allow given spender to transfer given number of tokens from message sender.
     *
     * @param db storage
     * @param _caller address
     * @param _spender address to allow the owner of to transfer tokens from
     *         message sender
     * @param _value number of tokens to allow to transfer
     * @return true if token transfer was successfully approved, false otherwise
     */
    function approve(TokenStorage db, address _caller, address _spender, uint256 _value) returns (bool success) {
        db.setAllowed(_caller, _spender, _value);
        Approval(_caller, _spender, _value);
        return true;
    }

    /**
     * @dev Approve and then communicate the approved contract in a single transaction
     *
     * @param db storage
     * @param _caller address
     * @param _spender Address of token spender.
     * @param _value Amount.
     * @param _extraData bytes
     */
	function approveAndCall(TokenStorage db, address _caller, address _spender, uint256 _value, bytes _extraData) returns (bool success) {
		TokenRecipient spender = TokenRecipient(_spender);
		if (approve(db, _caller, _spender, _value)) {
			spender.receiveApproval(_caller, _value, this, _extraData);
			return true;
		}
	}

    // EXTERNAL CONSTANT
    function balanceOf(TokenStorage db, address _owner)
        constant
        returns (uint256 balance)
    {
        return db.getBalance(_owner);
    }

    function allowance(TokenStorage db, address _owner, address _spender)
        constant
        returns (uint256 remaining)
    {
        return db.getAllowed(_owner, _spender);
    }
}
