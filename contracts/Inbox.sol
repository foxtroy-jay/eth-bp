pragma solidity ^0.5.10;

contract Inbox {

//   bytes32[] public message;
mapping(address => bytes32[]) public tweets;

  constructor() public {
    // message.push(stringToBytes32(_message));
  }

//   function getMessage() public view returns (mapping(address => bytes32[]) ){
//       return tweets;
//   }

    function getMessageIndex(uint index) public view returns (bytes32){
      return tweets[msg.sender][index];
  }

      function getMessageLength() public view returns (uint){
      return tweets[msg.sender].length;
  }

  function setMessage(string memory newMessage) public {
      tweets[msg.sender].push(stringToBytes32(newMessage));
  }

    function getLatestTweet() public view returns (string memory){
      uint latest = tweets[msg.sender].length - 1;
      return bytes32ToStr(tweets[msg.sender][latest]);
  }

  function stringToBytes32(string memory source) private returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
  }

  function bytes32ToStr(bytes32 _bytes32) public view returns (string memory){

   // string memory str = string(_bytes32);
   // TypeError: Explicit type conversion not allowed from "bytes32" to "string storage pointer"
   // thus we should fist convert bytes32 to bytes (to dynamically-sized byte array)

   bytes memory bytesArray = new bytes(32);
   for (uint256 i; i < 32; i++) {
       bytesArray[i] = _bytes32[i];
       }
   return string(bytesArray);
   }


}
