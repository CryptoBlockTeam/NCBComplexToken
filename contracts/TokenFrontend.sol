/*
 * TokenFrontend
 * 
 * Copyright © 2017 by OrangeBlockLab.
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

import "./helper/Ownable.sol";
import "./controller/SmartController.sol";

contract TokenFrontend is Ownable {

    SmartController private controller;
    string public name;
    string public symbol;
    bytes3 public ticker;

    // EVENTS
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // CONSTRUCTOR
    function TokenFrontend(string _name, string _symbol, bytes3 _ticker, uint256 _initialSupply, uint256 _capAmount, address _controller) {
        name = _name;
        symbol = _symbol;
        ticker = _ticker;

        setController(_controller);

        if(!controller.increaseCapAmount(_capAmount)) revert();
        
        // mint initial supply
        if (!controller.mint(_initialSupply)) revert();
    }

    // EXTERNAL
    function setController(address _address) onlyOwner {
        assert(_address != 0x0);
        controller = SmartController(_address);
        controller.setFrontend(this);
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        success = controller._transfer(msg.sender, _to, _value);
        Transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        return controller._transferFrom(msg.sender, _from, _to, _value);
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        success = controller._approve(msg.sender, _spender, _value);
        Approval(msg.sender, _spender, _value);
    }

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
        success = controller._approveAndCall(msg.sender, _spender, _value, _extraData);
		Approval(msg.sender, _spender, _value);
    }

    // EXTERNAL CONSTANT
    function getController() onlyOwner constant returns (address) {
        return address(controller);
    }

    function totalSupply() constant returns (uint256) {
        return controller.totalSupply();
    }

    function capAmount() constant returns (uint256) {
        return controller.capAmount();
    }

    function balanceOf(address _who) constant returns (uint256) {
        return controller.balanceOf(_who);
    }

    function allowance(address _owner, address _spender) constant returns (uint256) {
        return controller.allowance(_owner, _spender);
    }

    function decimals() constant returns (uint256) {
        return controller.decimals();
    }
}
