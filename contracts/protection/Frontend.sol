/**
 * Frontend protection Smart Contract implementation.
 * 
 * Copyright © 2017 by OrangeBlockLab.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).
 */

pragma solidity ^0.4.11;

import "../TokenFrontend.sol";

contract Frontend {

	TokenFrontend public frontend;

    /** 
     * @dev Throws if called by any account other than the frontend
     */
    modifier onlyFrontend() {
        if (msg.sender == address(frontend))
            _;
    }

    /** 
     * @dev Throws if called by any account other than the frontend or direct call
     */
    modifier isFrontend(address caller) {
        if (msg.sender == address(frontend) || msg.sender == caller)
            _;
    }

    /** 
     * @dev Throws if called by any account other than the frontend or owner
     */
    modifier ownerOrFrontend(address own) {
        if (msg.sender == address(frontend) || tx.origin == own)
            _;
    }
}