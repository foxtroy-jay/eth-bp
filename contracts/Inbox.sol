pragma solidity ^0.5.10;

contract Inbox {

  string public message;

  constructor(string memory _message) public {
    message = _message;
  }

  function getMessage(string memory initialMessage) public {
      message = initialMessage;
  }

  function setMessage(string memory newMessage) public {
      message = newMessage;
  }
}
