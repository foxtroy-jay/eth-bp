pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;


contract Factory {
struct User {
    address userAddress;
}

mapping(address => User[]) allUsers;

mapping(address => string[]) private tweets;
address[] public keyList;

function findOrCreate() public {
    //If user doesn't exist
    if(allUsers[msg.sender].length == 0){
        //Currently not creating correctly
        NEWUser newUser = new NEWUser(msg.sender);
        keyList.push(msg.sender);
        allUsers[msg.sender].push(User(msg.sender));
    } 
}
  
 function getAllUsersIndex() public view returns (User[] memory){
     return allUsers[msg.sender];
}
  
// function addStructMessage(string memory tweet) public {

//     mappingTest[msg.sender].push(Entry(tweet));
// }

// function checkStructMessage(uint index) public view returns (string memory){
//     return mappingTest[msg.sender][index].text;
// }


//   function getMessageLength() public view returns (uint){
//       return tweets[msg.sender].length;
//   }

//   function getKeys() public view returns (address[] memory) {
//         return keyList;

//   }
}

contract NEWUser {
    constructor (address creator) public{
        address manager = creator;
    }
    struct Tweet {
        string text;
        string hashtag;
        uint blockNum;
        mapping(uint => string) replies;
    }
    
    mapping(uint => Tweet) public allTweets;
    address[] following;
    address[] follows;
    uint numTweets;    
        
    // function setMessage(string memory newMessage) public {
    //     allTweets.push(newMessage);
    // }
    
    function addStructTweet(string memory tweet) public {
    //block.timeStamp or now will both return blocktime in uint
        allTweets[numTweets] = Tweet(tweet,'',block.number);
        numTweets++;
    }
    
    //same as calling from allTweets
    function getMessageByIndex(uint index) public view returns (string memory) {
        return allTweets[index].text;
    }
  
    // function fetchUserTweets(address user) public view returns (string[] memory) {
    //     return allTweets;
    // }
}
