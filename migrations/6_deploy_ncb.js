// artifacts
var SmartController = artifacts.require("SmartController")
var NCBToken = artifacts.require("NCBComplexToken")

module.exports = function(deployer) {
  deployer.deploy(NCBToken, SmartController.address, 10000000000000000, 50000000000000000)
}
