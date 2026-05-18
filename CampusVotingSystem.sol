// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CampusVotingSystem {

    // Admin
    address public admin;

    //Candidate structure
    struct Candidate {
        string name;
        uint voteCount;
    }

    // List of candidates
    Candidate[] public candidates;

    // Track eligible voters
    mapping(address => bool) public isEligibleVoter;

    // Prevent double voting
    mapping(address => bool) public hasVoted;

    //  Constructor runs once when deployed
    constructor() {
        admin = msg.sender;

        // Initialize 3 candidates
        candidates.push(Candidate("Candidate A", 0));
        candidates.push(Candidate("Candidate B", 0));
        candidates.push(Candidate("Candidate C", 0));
    }

    //  Only admin can execute certain functions
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin allowed");
        _;
    }

    // Only registered voters can vote
    modifier onlyEligibleVoter() {
        require(isEligibleVoter[msg.sender], "Not an eligible voter");
        _;
    }

    // Register voter
    function registerVoter(address voter) public onlyAdmin {
        isEligibleVoter[voter] = true;
    }

    // Voting function
    function vote(uint candidateIndex) public onlyEligibleVoter {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount++;
    }

    // Get full election results
    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Get number of candidates
    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }
}