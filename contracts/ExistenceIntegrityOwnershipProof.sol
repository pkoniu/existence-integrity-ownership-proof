pragma solidity 0.4.24;

contract ExistenceIntegrityOwnershipProof {
    struct OwnershipSignature {
        uint v;
        bytes32 r;
        bytes32 s;
    }

    struct OwnershipDetails {
        address currentOwner;
        OwnershipSignature ownerSignature;
    }

    mapping (string => OwnershipDetails[]) objectsToOwnerships;

    event logOwnershipChangedStatus(bool status, address currentOwner, string objectID);

    function setNewOwner(address newOwner, address prevOwner, string objectID, uint oldV, bytes32 oldR, bytes32 oldS, uint newV, bytes32 newR, bytes32 newS) public {
        // OwnershipSignature memory oldSignature = OwnershipSignature({
        //     v: oldV,
        //     r: oldR,
        //     s: oldS
        // });

        OwnershipSignature memory newSignature = OwnershipSignature({
            v: newV,
            r: newR,
            s: newS
        });

        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];

        if (currentObjectsHistory.length > 0) {
            OwnershipDetails currentOwnership = currentObjectsHistory[currentObjectsHistory.length - 1];
        }
        
        if (currentObjectsHistory.length == 0 || currentOwnership.currentOwner == prevOwner) {
            OwnershipDetails memory newOwnership = OwnershipDetails({
                currentOwner: newOwner,
                ownerSignature: newSignature
            });
            currentObjectsHistory.push(newOwnership);
            emit logOwnershipChangedStatus(true, newOwner, objectID);
        } else {
            emit logOwnershipChangedStatus(false, newOwner, objectID);
        }
    }

    function getCurrentOwnershipDetails(string objectID) public view returns (address currentOwner) {
        OwnershipDetails[] currentObjectsHistory = objectsToOwnerships[objectID];
        uint objectsHistoryLength = currentObjectsHistory.length;
        OwnershipDetails lastOwnership = currentObjectsHistory[objectsHistoryLength - 1];
        return lastOwnership.currentOwner;
    }
}
