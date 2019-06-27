const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const provider = ganache.provider();

const OPTIONS = {
  defaultBlock: 'latest',
  transactionConfirmationBlocks: 1,
  transactionBlockTimeout: 5,
};

const web3 = new Web3(provider, null, OPTIONS);
const compiledContract = require('../compile');
let interface = compiledContract['contracts']['Inbox.sol']['Inbox']['abi'];
let bytecode =
  compiledContract['contracts']['Inbox.sol']['Inbox']['evm']['bytecode'][
    'object'
  ];

// const INITIAL_VALUE = 'Hi there!';
const INITIAL_VALUE = 'Pellentesque elit nulla posuere.';
let accounts;
let inbox;
beforeEach(async () => {
  accounts = await web3.eth.getAccounts();
  inbox = await new web3.eth.Contract(interface, accounts[0])
    .deploy({
      data: bytecode,
    })
    .send({
      from: accounts[0],
      gas: 1000000,
    });
});

describe('Inbox', () => {
  it('deploys a contract', () => {
    // console.log(inbox);
    assert.ok(inbox.options.address);
  });
  it('set and get tweet', async () => {
    await inbox.methods.setMessage(INITIAL_VALUE).send({ from: accounts[0] });
    const response = await inbox.methods.getLatestTweet().call();
    const newResponse = response.slice(0, INITIAL_VALUE.length);
    assert.equal(newResponse, INITIAL_VALUE);
  });
  it('created tweet only 32 bytes', async () => {
    await inbox.methods
      .setMessage('Pellentesque elit nulla posuere....')
      .send({ from: accounts[0] });
    const response = await inbox.methods.getLatestTweet().call();
    assert.equal(response, 'Pellentesque elit nulla posuere.');
  });
});
