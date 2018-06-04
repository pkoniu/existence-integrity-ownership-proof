pragma solidity ^0.4.23;

contract ExistenceIntegrityOwnershipProof {
    struct ObjectDetails {
        uint createdAt;
        string currentOwner;
    }

    mapping (string => ObjectDetails) objects;

    event logObjectAddedStatus(bool status, uint createdAt, string currentOwner, string objectHash);

    function setNewOwner(string newOwner, string objectHash) private {
        if (objects[objectHash].createdAt == 0) {
            objects[objectHash] = ObjectDetails(block.timestamp, newOwner);
        } else {
            emit logObjectAddedStatus(false, block.timestamp, newOwner, objectHash);
        }
    }

    function getOwner(string objectHash) public returns (uint createdAt, string currentOwner) {
        return (objects[objectHash].createdAt, objects[objectHash].currentOwner);
    }
}
