// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

contract TrustlessRep is Ownable {
    struct Credential {
        address issuer;
        address minerAddress;
        string name;
        string rating;
        uint stakeAmount;
        string issueDate;
    }

    mapping(string => Credential) public credentials;

    event IdentityAttestation(
        address indexed subject,
        address indexed issuer,
        bytes32 indexed data
    );

    function issueCredential(
        address minerAddress,
        string memory name,
        string memory rating,
        string memory issueDate
    ) public onlyOwner {
        credentials[name] = Credential({
            issuer: msg.sender,
            minerAddress: minerAddress,
            name: name,
            rating: rating,
            stakeAmount: 0,
            issueDate: issueDate
        });
        // credentials = Credential(msg.sender, name, rating, 0, issueDate);
        // credentials = Credential(msg.sender, name, rating, 0, issueDate);
        emit IdentityAttestation(
            minerAddress,
            msg.sender,
            keccak256(abi.encodePacked(name, rating, issueDate))
        );
    }

    function updateCredential(string memory name, string memory rating) public onlyOwner {
        credentials[name].rating = rating;

        emit IdentityAttestation(
            credentials[name].minerAddress,
            msg.sender,
            keccak256(abi.encodePacked(name, rating, credentials[name].issueDate))
        );
    }

    function stake(string memory name) public payable {
        require(msg.value > 0, "Stake value must be greater than 0");
        credentials[name].stakeAmount += msg.value;
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
