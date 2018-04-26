/*
 * NCBComplexToken
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

import "./TokenFrontend.sol";

contract NCBComplexToken is TokenFrontend {
    string public version = '0.0.1';

    // Constructor
    function NCBComplexToken(address _controller, uint256 initialSupply, uint256 capAmount) TokenFrontend("NewCryptoBlock Complex Token", "NCB", "NCB", initialSupply, capAmount, _controller) {}
}
