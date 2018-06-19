const HDWalletProvider = require('truffle-hdwallet-provider')

const {
  secretMnemonic = '',
} = require('./secrets');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    }
  }
}