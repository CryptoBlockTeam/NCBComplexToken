/*
 * MintableTokenLib
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

import "./SafeMathLib.sol";
import "../controller/TokenStorage.sol";

library MintableTokenLib {
    using SafeMathLib for uint256;

    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    event IncreaseCap(uint256 amount);
    event DecreaseCap(uint256 amount);

    /**
     * @dev Function to mint tokens
     * @param _to The address that will recieve the minted tokens.
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(TokenStorage self, address _to, uint256 _amount) constant returns (bool) {
        self.addBalance(_to, _amount);
        Mint(_to, _amount);
        return true;
    }

    /**
     * @dev Function to burn tokens
     * @param _from The address that will be impacted.
     * @param _amount The amount of tokens to be burned.
     * @return A boolean that indicates if the operation was successful.
     */
    function burn(TokenStorage self, address _from, uint256 _amount) constant returns (bool) {
        self.subBalance(_from, _amount);
        Burn(_from, _amount);
        return true;
    }

    /**
     * @dev Function to increase tokens cap amount
     * @param _amount The amount of tokens to increase the cap.
     * @return A boolean that indicates if the operation was successful.
     */
    function increaseCapAmount(TokenStorage self, uint256 _amount) constant returns (bool) {
        self.increaseCap(_amount);
        IncreaseCap(_amount);
        return true;
    }

    /**
     * @dev Function to decrease tokens cap amount
     * @param _amount The amount of tokens to decrease the cap.
     * @return A boolean that indicates if the operation was successful.
     */
    function decreaseCapAmount(TokenStorage self, uint256 _amount) constant returns (bool) {
        self.decreaseCap(_amount);
        DecreaseCap(_amount);
        return true;
    }
}
