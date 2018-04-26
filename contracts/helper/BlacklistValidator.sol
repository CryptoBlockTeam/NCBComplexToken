/*
 * BlacklistValidator
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

import "./Ownable.sol";
import "../interface/ValidatorInterface.sol";

contract BlacklistValidator is ValidatorInterface, Ownable {

    mapping (address => bool) public blacklist;

    // EVENTS
    event Ban(address indexed adversary);
    event Unban(address indexed goodguy);

    // EXTERNAL
    /**
     * @dev ban - ban specified adversary
     *
     * @param _adversary address of _adversary to be baned
     */
    function ban(address _adversary) onlyOwner {
       blacklist[_adversary] = true;
       Ban(_adversary);
    }

    /**
     * @dev unban - unban specified advesary
     *
     * @param _goodguy address of advesary to be unbaned
     */
    function unban(address _goodguy) onlyOwner {
        blacklist[_goodguy] = false;
        Unban(_goodguy);
    }

    // EXTERNAL CONSTANT
     /**
     * @dev address validation function
     * @param _from address
     * @param _to address
     * @param _value uint256
     * @return success.
     */
    function validate(address _from, address _to, uint256 _value) constant returns (bool valid) {
        valid = true;
        if (blacklist[_from]) valid = false;
        Decision(_from, _to, valid, _value);
    }

}
