pragma solidity 0.4.25;

contract Election {
    // candidate structure
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters;// for voter list anready voted
    mapping(uint => Candidate) public candidates; //map every candidate and fetch details
    uint public candidatesCount;
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Himanshu");
        addCandidate("Dipesh");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
      // require that they haven't voted before
      require(!voters[msg.sender]);

      require(_candidateId > 0 && _candidateId <= candidatesCount); //voter validation
      voters[msg.sender] = true;
      candidates[_candidateId].voteCount ++;
      emit votedEvent(_candidateId);
     }
}
