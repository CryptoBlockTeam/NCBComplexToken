/*
 * Validator
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

contract ValidatorInterface {

    // EVENTS
    event Decision(address indexed from, address indexed to, bool valid, uint value);

    /**
     * @dev address validation function
     * @param _from address
     * @param _to address
     * @param value uint256
     * @return success.
     */
    function validate(address _from, address _to, uint256 value) constant returns (bool);
}
