pragma solidity 0.4.24;

contract ExistenceIntegrityOwnershipProof {
    struct OwnershipDetails {
        uint createdAt;
        address currentOwner;
    }

    mapping (string => OwnershipDetails[]) objectsToOwnerships;

    event logOwnershipChangedStatus(bool status, uint createdAt, address currentOwner, string objectID);

    function setNewOwner(address newOwner, address prevOwner, string objectID, uint timestamp) public {
        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];
        uint historyLength = currentObjectsHistory.length;

        if (historyLength > 0) {
            OwnershipDetails currentOwnership = currentObjectsHistory[historyLength - 1];
        }
        
        if (historyLength == 0 || currentOwnership.currentOwner == prevOwner) {
            OwnershipDetails memory newOwnership2 = OwnershipDetails({
                createdAt: timestamp,
                currentOwner: newOwner
            });
            currentObjectsHistory.push(newOwnership2);
            emit logOwnershipChangedStatus(true, timestamp, newOwner, objectID);
        } else {
            emit logOwnershipChangedStatus(false, timestamp, newOwner, objectID);
        }
    }

    function getCurrentOwnershipDetails(string objectID) public view returns (address currentOwner) {
        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];
        uint objectsHistoryLength = currentObjectsHistory.length;
        OwnershipDetails lastOwnership = currentObjectsHistory[objectsHistoryLength - 1];
        return lastOwnership.currentOwner;
    }
}
