// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {
    address public admin;
    uint public endTime;
    bool public votingEnded;

    struct Proposal {
        string name;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public whitelist;
    mapping(address => bool) public hasVoted;

    event ProposalAdded(string proposalName);
    event Voted(address voter, uint proposalIndex);
    event VotingEnded();

    modifier onlyAdmin() {
        require(msg.sender == admin, "Solo el administrador puede realizar esta accion");
        _;
    }

    modifier onlyWhitelisted() {
        require(whitelist[msg.sender], "No estas en la lista de permitidos para votar");
        _;
    }

    modifier votingPeriodActive() {
        require(block.timestamp < endTime && !votingEnded, "El periodo de votacion ha terminado");
        _;
    }

    constructor() {
        admin = msg.sender;
        endTime = block.timestamp + 3 days;  // Definir el tiempo de votacion de 3 dias
    }

    // Anadir propuestas (solo admin)
    function addProposal(string calldata _name) external onlyAdmin {
        proposals.push(Proposal({
            name: _name,
            voteCount: 0
        }));
        emit ProposalAdded(_name);
    }

    // Anadir votante a la whitelist (solo admin)
    function addToWhitelist(address _voter) external onlyAdmin {
        whitelist[_voter] = true;
    }

    // Votar por una propuesta (solo para direcciones en whitelist)
    function vote(uint _proposalIndex) external onlyWhitelisted votingPeriodActive {
        require(!hasVoted[msg.sender], "Ya has votado");
        require(_proposalIndex < proposals.length, "Propuesta no valida");

        proposals[_proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
        
        emit Voted(msg.sender, _proposalIndex);
    }

    // Terminar la votacion manualmente (opcional)
    function endVoting() external onlyAdmin {
        votingEnded = true;
        emit VotingEnded();
    }

    // Obtener informacion de una propuesta en particular
    function getProposal(uint _proposalIndex) external view returns (string memory name, uint voteCount) {
        require(_proposalIndex < proposals.length, "Propuesta no valida");
        Proposal storage proposal = proposals[_proposalIndex];
        return (proposal.name, proposal.voteCount);
    }

    // Obtener el numero total de propuestas
    function getProposalCount() external view returns (uint) {
        return proposals.length;
    }
}
