/*
 * SmartTokenLib
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

import "../interface/ValidatorInterface.sol";

library SmartTokenLib {
    struct SmartTokenStorage {
        ValidatorInterface validator;
    }

    // EXTERNAL
    function setValidator(SmartTokenStorage storage self, address _validator) {
        self.validator = ValidatorInterface(_validator);
    }

    function validate(SmartTokenStorage storage self, address _from, address _to, uint256 _value) returns (bool valid) {
        return self.validator.validate(_from, _to, _value);
    }

    // EXTERNAL CONSTANT
    function getValidator(SmartTokenStorage storage self) constant returns (address) {
        return address(self.validator);
    }
}
