const HDWalletProvider = require('truffle-hdwallet-provider')

const { 
  secretMnemonic = '',
} = require('./secrets');

module.exports = {
    networks: {
        live: {
            network_id: "*"
        },
        ropsten: {
            provider: new HDWalletProvider(secretMnemonic, 'https://ropsten.infura.io/'),
            network_id: '3'
        },
        testrpc: {
            network_id: 'default'
        },
        truffle_develop: {
          port: 8545,
          host: "localhost",
          network_id: "4447",
        },
        coverage: {
            host: "localhost",
            network_id: "*",
            port: 8545,
            gas: 0xfffffffffff,
            gasPrice: 0x01
        },
        development: {
            port: 8545,
            host: "localhost",
            network_id: "*",
        },
    }
}