// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TrustlessRep {
    struct Credential {
        address issuer;
        string name;
        string rating;
        string issueDate;
    }

    mapping(string => Credential) public credentials;
    mapping(address => mapping(address => bool)) public authorized;

    event IdentityAttestation(
        address indexed subject,
        address indexed issuer,
        bytes32 indexed data
    );

    function issueCredential(
        address holder,
        string memory name,
        string memory rating,
        string memory issueDate
    ) public {
        require(authorized[holder][msg.sender]);
        credentials[name] = Credential(msg.sender, name, rating, issueDate);
        emit IdentityAttestation(
            holder,
            msg.sender,
            keccak256(abi.encodePacked(name, rating, issueDate))
        );
    }

    function getCredential(
        string memory name
    ) public view returns (address, string memory, string memory, string memory) {
        return (
            credentials[name].issuer,
            credentials[name].name,
            credentials[name].rating,
            credentials[name].issueDate
        );
    }
}
