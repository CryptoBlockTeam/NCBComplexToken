var NCBToken = artifacts.require("./NCBComplexToken.sol")
var TokenStorage = artifacts.require("./TokenStorage.sol")
var SmartController = artifacts.require("./SmartController.sol")
var BlacklistValidator = artifacts.require("./BlacklistValidator.sol")

contract("NCBComplexToken", (accounts) => {
  let token
  let controller
  before(async function () {
    token = await NCBToken.deployed()
    let name = await token.name()
    let symbol = await token.symbol()
    let version = await token.version()
    let decimals = await token.decimals()

    var contractInfo = '';
    contractInfo ="  " + "-".repeat(40);
    contractInfo += "\n  " + "Current date is: " + new Date().toLocaleString("en-US", {timeZone: "UTC"});
    contractInfo += "\n  " + "-".repeat(40);

    contractInfo += "\n  Token Name: " + name
    contractInfo += "\n  Token Symbol: " + symbol
    contractInfo += "\n  Decimals: " + decimals
    contractInfo += "\n  Version: " + version
    contractInfo += "\n  " + "=".repeat(40);

    console.log(contractInfo)
  })
  it("should start with 100 mio tokens", () => {
    return NCBToken.deployed()
      .then(token => token.totalSupply())
      .then((supply) => assert.equal(supply.valueOf(), 10000000000000000, "initial supply is not 100,000,000.00000000"))
  })

  it("should start with 500 mio tokens cap", () => {
    return NCBToken.deployed()
      .then(token => token.capAmount())
      .then((cap) => assert.equal(cap.valueOf(), 50000000000000000, "initial cap amount is not 500,000,000.00000000"))
  })

  it("should increase cap amount with 74000", () => {
    return SmartController.deployed().then((token) => {
      return token.increaseCapAmount(74000, { from: accounts[0] })
        .then(() => token.capAmount())
        .then((cap) => assert.equal(cap.valueOf(), 50000000000074000, "did not increase cap with 74000"))
    })
  })

  it("should decrease cap amount with 74000", () => {
    return SmartController.deployed().then((token) => {
      return token.decreaseCapAmount(74000, { from: accounts[0] })
        .then(() => token.capAmount())
        .then((cap) => assert.equal(cap.valueOf(), 50000000000000000, "did not decrease cap with 74000"))
    })
  })

  it("should mint 74000 new tokens", () => {
    return SmartController.deployed().then((token) => {
      return token.mint(74000, { from: accounts[0] })
        .then(() => token.totalSupply())
        .then((balance) => assert.equal(balance.valueOf(), 10000000000074000, "did not mint 74000 tokens"))
    })
  })

  it("should have 74000 new tokens", () => {
    return SmartController.deployed().then((token) => {
      return token.balanceOf(accounts[0])
        .then((balance) => assert.equal(balance.valueOf(), 10000000000074000, "did not have additional 74000 tokens"))
    })
  })


  it("should burn 74000 tokens", () => {
    return SmartController.deployed().then((token) => {
      return token.burn(74000)
        .then(() => token.totalSupply())
        .then((balance) => assert.equal(balance.valueOf(), 10000000000000000, "did not burn 74000 tokens"))
    })
  })

  it("should transfer 7200 tokens to second account", () => {
    return NCBToken.deployed().then((token) => {
      return token.transfer(accounts[1], 7200)
        .then(() => token.balanceOf(accounts[1]))
        .then((balance) => assert.equal(balance.valueOf(), 7200, "did not transfer 7200 tokens"))
    })
  })
})
