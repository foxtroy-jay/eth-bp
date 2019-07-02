pragma solidity ^0.5.10;
pragma experimental ABIEncoderV2;


contract Inbox {

 struct Entry{
        string text;
    }

mapping(address => Entry[]) mappingTest;

mapping(address => string[]) private tweets;
address[] private keyList;

  constructor() public {
  }
function addStructMessage(string memory tweet) public {

    mappingTest[msg.sender].push(Entry(tweet));
}

function checkStructMessage(uint index) public view returns (string memory){
    return mappingTest[msg.sender][index].text;
}

  function getMessageLength() public view returns (uint){
      return tweets[msg.sender].length;
  }

  function setMessage(string memory newMessage) public {
    if(tweets[msg.sender].length == 0){
        keyList.push(msg.sender);
    }

    tweets[msg.sender].push(newMessage);
  }

  function getMessageByIndex(uint index) external view returns (string memory) {
    return tweets[msg.sender][index];
  }

  function fetchUserTweets(address user) public view returns (string[] memory) {
    return tweets[user];
  }

  function getKeys() public view returns (address[] memory) {
        return keyList;

  }
}
