var ExistenceIntegrityOwnershipProof = artifacts.require("ExistenceIntegrityOwnershipProof");

module.exports = function(deployer) {
  deployer.deploy(ExistenceIntegrityOwnershipProof);
};
