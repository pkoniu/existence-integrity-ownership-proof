const ExistenceIntegrityOwnershipProof = artifacts.require('ExistenceIntegrityOwnershipProof.sol');

contract('ExistenceIntegrityOwnershipProof', async (accounts) => {
    it('should save new ownership details', async () => {
        const instance = await ExistenceIntegrityOwnershipProof.deployed();
        await instance.setNewOwner(accounts[1], '123', Date.now());

        const ownerOf123 = await instance.getCurrentOwnershipDetails('123');

        assert.equal(ownerOf123, accounts[1]);
    });
});
