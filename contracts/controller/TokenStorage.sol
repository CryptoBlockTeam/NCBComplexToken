/*
 * TokenStorage - responsible for storing tokens
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

import "../helper/Ownable.sol";
import "../lib/TokenStorageLib.sol";

contract TokenStorage is Ownable {
    using TokenStorageLib for TokenStorageLib.Storage;

    TokenStorageLib.Storage tokenStorage;

    // EXTERNAL
    function addBalance(address _to, uint256 _amount) onlyOwner {
        tokenStorage.addBalance(_to, _amount);
    }

    function subBalance(address _from, uint256 _amount) onlyOwner {
        tokenStorage.subBalance(_from, _amount);
    }

    function setAllowed(address _owner, address _spender, uint256 _amount) onlyOwner {
        tokenStorage.setAllowed(_owner, _spender, _amount);
    }

    function increaseCap(uint256 _amount) onlyOwner {
        tokenStorage.increaseCap(_amount);
    }

    function decreaseCap(uint256 _amount) onlyOwner {
        tokenStorage.decreaseCap(_amount);
    }

    // EXTERNAL CONSTANT
    function getSupply() constant returns (uint256) {
        return tokenStorage.getSupply();
    }

    function getCap() constant returns (uint256) {
        return tokenStorage.getCap();
    }

    function getBalance(address _who) constant returns (uint256) {
        return tokenStorage.getBalance(_who);
    }

    function getAllowed(address _owner, address _spender) constant returns (uint256)
    {
        return tokenStorage.getAllowed(_owner, _spender);
    }
}
