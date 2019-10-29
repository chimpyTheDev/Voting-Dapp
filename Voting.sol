pragma solidity ^0.5.1;


contract Voting{
    mapping(bytes32 => uint256) public votesReceived;

    bytes32[] public candidateList;


    // We use an array of bytes32 because solidity doesnt allow passing of
    // strings arrays inside a constructor

    // We will convert this array to string values during deployment
    constructor(bytes32[] memory candidateNames) public {
        candidateList = candidateNames;
    }

    function totalVotesFor(bytes32 candidate)public view  returns (uint256) {
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    function voteForCandidate(bytes32 candidate) public {
        require(validCandidate(candidate));
        votesReceived[candidate] += 1;
    }

    function validCandidate(bytes32 candidate)public view  returns (bool) {
        for(uint i = 0; i < candidateList.length; i++){
            if (candidateList[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}

// THIS IS HOW TO DEPLOY THE CONTRACT ONTO GANACHE:

// deployedContract.deploy({
//   data: bytecode,
//   arguments: [listOfCandidates.map(name => web3.utils.asciiToHex(name))]
// }).send({
//   from: '0x01C7514F15f240F084481DEC1A114F8A13A29c56',
//   gas: 1500000,
//   gasPrice: web3.utils.toWei('0.00003', 'ether')
// }).then((newContractInstance) => {
//   deployedContract.options.address = newContractInstance.options.address
//   console.log(newContractInstance.options.address)
// });

