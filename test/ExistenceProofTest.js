const ExistenceIntegrityOwnershipProof = artifacts.require('ExistenceIntegrityOwnershipProof.sol');

contract('ExistenceIntegrityOwnershipProof', async (accounts) => {
    it('should save new ownership details for clean history', async () => {
        const instance = await ExistenceIntegrityOwnershipProof.deployed();
        await instance.setNewOwner(accounts[1], accounts[2], '123', 1, 'a', 'b', 2, 'c', 'd');

        const ownerOf123 = await instance.getCurrentOwnershipDetails('123');

        assert.equal(ownerOf123, accounts[1]);
    });

    it('should save new ownership details only for correct chain of changes', async () => {
        const instance = await ExistenceIntegrityOwnershipProof.deployed();
        await instance.setNewOwner(accounts[1], accounts[2], '124', 1, 'a', 'b', 2, 'c', 'd');
        await instance.setNewOwner(accounts[2], accounts[1], '124', 1, 'a', 'b', 2, 'c', 'd');

        const ownerOf124 = await instance.getCurrentOwnershipDetails('124');

        assert.equal(ownerOf124, accounts[2]);
    });

    it('should not save new ownership details if prev owner incorrect', async () => {
        const instance = await ExistenceIntegrityOwnershipProof.deployed();
        await instance.setNewOwner(accounts[1], accounts[2], '125', 1, 'a', 'b', 2, 'c', 'd');
        await instance.setNewOwner(accounts[2], accounts[3], '125', 1, 'a', 'b', 2, 'c', 'd');

        const ownerOf125 = await instance.getCurrentOwnershipDetails('125');

        assert.equal(ownerOf125, accounts[1]);
    });
});
