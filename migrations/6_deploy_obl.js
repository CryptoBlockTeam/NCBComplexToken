// artifacts
var SmartController = artifacts.require("SmartController")
var OBLToken = artifacts.require("OBLComplexToken")

module.exports = function(deployer) {
  deployer.deploy(OBLToken, SmartController.address, 10000000000000000, 50000000000000000)
}
