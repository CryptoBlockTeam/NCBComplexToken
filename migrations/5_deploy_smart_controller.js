// artifacts
var ERC20Lib = artifacts.require("ERC20Lib")
var SmartTokenLib = artifacts.require("SmartTokenLib")
var BlacklistValidator = artifacts.require("BlacklistValidator")
var TokenStorageLib = artifacts.require("TokenStorageLib")
var TokenStorage = artifacts.require("TokenStorage")
var MintableTokenLib = artifacts.require("MintableTokenLib")
var SmartController = artifacts.require("SmartController")

module.exports = function(deployer) {
  deployer.link(ERC20Lib, SmartController)
  deployer.link(TokenStorageLib, SmartController)
  deployer.link(SmartTokenLib, SmartController)
  deployer.link(MintableTokenLib, SmartController)
  deployer.deploy(SmartController, TokenStorage.address, BlacklistValidator.address)
}
