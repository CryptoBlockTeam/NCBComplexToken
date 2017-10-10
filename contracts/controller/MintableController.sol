/*
 * MintableController 
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

import "../lib/MintableTokenLib.sol";
import "./StandardController.sol";

contract MintableController is StandardController {
    using MintableTokenLib for TokenStorage;

    // EVENTS
    event Mint(address indexed _to, uint256 _amount);
    event Burn(address indexed _from, uint256 _amount);

    event IncreaseCap(uint256 amount);
    event DecreaseCap(uint256 amount);

    // CONSTRUCTOR
    function MintableController(address _storage, uint256 initialSupply, uint256 capAmount) StandardController(_storage, initialSupply, capAmount) { 
        // nothing else to do
    }

    // EXTERNAL
    function mint(uint256 _amount) ownerOrFrontend(owner) returns (bool) {
        if (token.mint(owner, _amount)) {
            return true;
        }
        return false;
    }

    function burn(uint256 _amount) ownerOrFrontend(owner) returns (bool) {
        if (token.burn(msg.sender, _amount)) {
            return true;
        }
        return false;
    }

    function increaseCapAmount(uint256 _amount) ownerOrFrontend(owner) returns (bool) {
        if (token.increaseCapAmount(_amount)) {
            return true;
        }
        return false;
    }

    function decreaseCapAmount(uint256 _amount) ownerOrFrontend(owner) returns (bool) {
        if (token.decreaseCapAmount(_amount)) {
            return true;
        }
        return false;
    }
}
