pragma solidity 0.4.24;

contract ExistenceIntegrityOwnershipProof {
    struct OwnershipDetails {
        uint createdAt;
        address currentOwner;
    }

    mapping (string => OwnershipDetails[]) objectsToOwnerships;

    event logOwnershipChangedStatus(bool status, uint createdAt, address currentOwner, string objectID);

    function setNewOwner(address newOwner, string objectID, uint timestamp) public {
        OwnershipDetails memory newOwnership = OwnershipDetails({
            createdAt: timestamp,
            currentOwner: newOwner
        });
        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];
        currentObjectsHistory.push(newOwnership);
        // OwnershipDetails[] ownershipDetailsForObject = objectsToOwnerships[objectID];
        // uint ownershipLength = ownershipDetailsForObject.length;
        // OwnershipDetails currentOwnership = ownershipDetailsForObject[ownershipLength - 1];
        // uint createdAt = currentOwnership.createdAt;
        // address currentOwner = currentOwnership.currentOwner;
        // if (objectsToOwnerships[objectHash].createdAt == 0) {
        //     objectsToOwnerships[objectHash] = OwnershipDetails(block.timestamp, newOwner);
        // } else {
        //     emit logOwnershipChangedStatus(false, block.timestamp, newOwner, objectHash);
        // }
    }

    function getCurrentOwnershipDetails(string objectID) public view returns (address currentOwner) {
        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];
        uint objectsHistoryLength = currentObjectsHistory.length;
        OwnershipDetails lastOwnership = currentObjectsHistory[objectsHistoryLength - 1];
        return lastOwnership.currentOwner;
        // return (objectsToOwnerships[objectHash].createdAt, objectsToOwnerships[objectHash].currentOwner);
    }
}
