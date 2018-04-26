/*
 * StandardController
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

import "../protection/Frontend.sol";
import "../protection/Pausable.sol";
import "../protection/Protection.sol";
import "./TokenStorage.sol";
import "../lib/ERC20Lib.sol";
import "../helper/Ownable.sol";

contract StandardController is Ownable, Frontend, Pausable, Protection {
    using ERC20Lib for TokenStorage;

    TokenStorage token;

    // EVENTS
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // CONSTRUCTOR
    function StandardController(address _storage, uint256 initialSupply, uint256 capAmount) {
        assert(_storage == 0x0 || initialSupply == 0 || capAmount == 0);
        if (_storage == 0x0) {
            token = new TokenStorage();
            token.increaseCap(capAmount);
            token.addBalance(msg.sender, initialSupply);
        } else {
            token = TokenStorage(_storage);
        }
    }

    // EXTERNAL

    function getFrontend() constant returns (address) {
        return address(frontend);
    }

    function getStorage() constant returns (address) {
        return address(token);
    }

    // EXTERNAL CONSTANT
    function setFrontend(address _address) ownerOrFrontend(owner) {
        frontend = TokenFrontend(_address);
    }

    // EXTERNAL ERC20
    function transfer(address _to, uint256 _value) returns (bool success) {
        return _transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        return _transferFrom(msg.sender, _from, _to, _value);
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        return _approve(msg.sender, _spender, _value);
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        return _approveAndCall(msg.sender, _spender, _value, _extraData);
    }

    // EXTERNAL ERC20 FRONT
    function _transfer(address _caller, address _to, uint256 _value)  whenNotPaused isFrontend(_caller) returns (bool success) {
        require(_value > 0);
        return token.transfer(_caller, _to, _value);
    }

    function _transferFrom(address _caller, address _from, address _to, uint256 _value) whenNotPaused onlyPayloadSize(3) isFrontend(_caller) returns (bool success) {
        require(_value > 0);
        return token.transferFrom(_caller, _from, _to, _value);
    }

    function _approve(address _caller, address _spender, uint256 _value) onlyPayloadSize(2) isFrontend(_caller) returns (bool success) {
        return token.approve(_caller, _spender, _value);
    }

    function _approveAndCall(address _caller, address _spender, uint256 _value, bytes _extraData)  onlyPayloadSize(2) returns (bool success) {
        return token.approveAndCall(_caller, _spender, _value, _extraData);
    }

    // EXTERNAL ERC20 CONSTANT
    function totalSupply() constant returns (uint256) {
        return token.getSupply();
    }

    function capAmount() constant returns (uint256) {
        return token.getCap();
    }

    function balanceOf(address who) constant returns (uint256) {
        return token.getBalance(who);
    }

    function allowance(address owner, address spender) constant returns (uint256) {
        return token.allowance(owner, spender);
    }

}
