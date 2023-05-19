// require("@nomicfoundation/hardhat-toolbox");
// require("dotenv").config({ path: ".env" });
// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.17",

//   networks: {
//     alfajores: {
//       url: "https://alfajores-forno.celo-testnet.org",
//       accounts: {
//         mnemonic: process.env.MNEMONIC,
//         path: "m/44'/52752'/0'/0"
//       },
//       chainId: 44787
//      // blockGasLimit: 6000000
//     }
//   }
// };

require("@nomicfoundation/hardhat-toolbox");

// require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

// task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
//   const accounts = await hre.ethers.getSigners();

//   for (const account of accounts) {
//     console.log(account.address);
//   }
// });

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "alfajores",
  networks: {
    localhost: {
      url: "http://127.0.0.1:7545",
    },
    alfajores: {
      url: "https://alfajores-forno.celo-testnet.org",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 44787,
    },
    celo: {
      url: "https://forno.celo.org",
      accounts: [process.env.PRIVATE_KEY],
      chainId: 42220,
    },
  },
  solidity: {
    version: "0.8.17",
  },
  namedAccounts: {
    deployer: 0,
  },
};

