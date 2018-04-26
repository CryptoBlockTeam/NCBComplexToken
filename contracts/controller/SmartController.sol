/*
 * SmartController
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

import "../lib/SmartTokenLib.sol";
import "../lib/MintableTokenLib.sol";
import "./MintableController.sol";

contract SmartController is MintableController {
    using SmartTokenLib for SmartTokenLib.SmartTokenStorage;
    using MintableTokenLib for SmartTokenLib.SmartTokenStorage;

    SmartTokenLib.SmartTokenStorage smartToken;

    uint256 public decimals = 8;
    uint256 public initialSupply = 0;
    uint256 public initialCapAmount = 0;

    // CONSTRUCTOR
    function SmartController(address _storage, address _validator) MintableController(_storage, initialSupply, initialCapAmount) {
        assert(_validator != 0x0);
        smartToken.setValidator(_validator);
    }

    // EXTERNAL
    function setValidator(address _validator) {
        smartToken.setValidator(_validator);
    }

    // EXTERNAL ERC20
    function transfer(address to, uint256 value) returns (bool ok) {
        return _transfer(msg.sender, to, value);
    }

    function _transfer(address _caller, address to, uint256 value) returns (bool ok) {
        if (!smartToken.validate(_caller, to, value)) {
            revert();
        }
        return super._transfer(_caller, to, value);
    }

    // EXTERNAL CONSTANT
    function getValidator() constant returns (address) {
        return smartToken.getValidator();
    }
}
