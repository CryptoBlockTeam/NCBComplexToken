### 1. Contract: TokenStorage

    1.1 Should not have initial supply
    
    1.2 Should have supply of 85000 after manually increasing to 85000
    
    1.3 Should have a supply of 73000 after explicitly reducing from 85000
    
    1.4 Should have a cumulative balance of 73000 in the first account
    
    1.5 Should have a balance of 30000 in second account
    
    1.6 Should fail when minting from a non-owner account

### 2. Contract: SmartController

    2.1 Should start with zero tokens

    2.2 Should start with zero cap amount limit
    
    2.3 Should mint 88000 new tokens

    2.4 should burn 2000 tokens

    2.5 Should trow error if in supply of 48000 you try to burn 50000
    
    2.6 Should transfer 3400 tokens to second account
    
    2.7 Should fail transfering 1840 tokens from a blacklisted account
    
    2.8 Should fail transfer if freez feature is on (this still needs to be implemented)

### 3. Contract: OBLComplexToken

    3.1 Should start with 100.000.000 initial token supply

    3.2 Should start with 500.000.000 initial capm amount limit
    
    3.3 Should increase cap amount limit with 74000 tokens

    3.4 Should decrease cap amount limit with 74000 tokens

    3.5 Should mint 74000 new tokens
        
    3.6 should burn 74000 tokens
    
    3.7 Should transfer 7200 tokens to second account
    
    3.8 Should allow third account to spend 9600 from the first account (this still needs to be implemented)
    
    3.9 Should transfer 9300 from the first account to the fourth using the third account (this still needs to be implemented)
    
    3.10 Should fail transfering 78 tokens from a blacklisted account (this still needs to be implemented)
    
    3.11 Should unblocklist the account and transfer 78 tokens from (this still needs to be implemented)
    
    3.12 Should prevent any transfer when freez is enabled (this still needs to be implemented)
    
    3.13 Should throw exception when using short address form (this still needs to be implemented)
