// artifacts
var SafeMathLib = artifacts.require("SafeMathLib")
var ERC20Lib = artifacts.require("ERC20Lib")
var SmartTokenLib = artifacts.require("SmartTokenLib")
var TokenStorageLib = artifacts.require("TokenStorageLib")
var TokenStorage = artifacts.require("TokenStorage")
var StandardController = artifacts.require("StandardController")
var MintableTokenLib = artifacts.require("MintableTokenLib")
var MintableController = artifacts.require("MintableController")
var SmartController = artifacts.require("SmartController")

module.exports = function(deployer) {

  // deploy and link libraries
  deployer.deploy(SafeMathLib)
  deployer.link(SafeMathLib, [
    TokenStorageLib,
    ERC20Lib
  ])

  deployer.deploy(TokenStorageLib)
  deployer.deploy(ERC20Lib)
  deployer.deploy([MintableTokenLib, SmartTokenLib])

}
