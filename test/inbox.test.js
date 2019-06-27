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
  compiledContract['contracts']['Inbox.sol']['Inbox']['evm']['bytecode'].object;

const INITIAL_VALUE = 'Hi there!';
let accounts;
let inbox;
beforeEach(async () => {
  accounts = await web3.eth.getAccounts();
  inbox = await new web3.eth.Contract(interface, accounts[0])
    .deploy({
      data: bytecode,
      arguments: [INITIAL_VALUE],
    })
    .send({
      from: accounts[0],
      gas: 1000000,
    });
});

describe('Inbox', () => {
  it('deploys a contract', () => {
    assert.ok(inbox.options.address);
  });
  it('has a default message', async () => {
    const message = await inbox.methods.message().call();
    assert.equal(message, INITIAL_VALUE);
  });
  it('can change the message', async () => {
    await inbox.methods.setMessage('bye').send({ from: accounts[0] });
    const message = await inbox.methods.message().call();
    assert.equal(message, 'bye');
  });
});
