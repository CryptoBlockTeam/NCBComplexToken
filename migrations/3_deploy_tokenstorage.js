// artifacts
var TokenStorageLib = artifacts.require("TokenStorageLib")
var TokenStorage = artifacts.require("TokenStorage")

module.exports = function(deployer) {
  deployer.link(TokenStorageLib, TokenStorage)
  deployer.deploy(TokenStorage, 0, 0)
}
