// artifacts
var BlacklistValidator = artifacts.require("BlacklistValidator")

module.exports = function(deployer) {
  deployer.deploy(BlacklistValidator)
}
