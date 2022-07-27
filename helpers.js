const { ethers } = require("ethers");
const { getContractAt } = require("@nomiclabs/hardhat-ethers/internal/helpers");

// 获取环境变量
function getEnvVariable(key, defaultValue) {
    if (process.env[key]) {
        return process.env[key];
    }

    if (!defaultValue) {
        throw `${key} is not defined and no default value was provided`;
    }

    return defaultValue;
}

function getProvider() {
    return ethers.getDefaultProvider(getEnvVariable("NETWORK", "rinkeby"), {
        alchemy: getEnvVariable("ALCHEMY_KEY", ""),
    });
}

function getAccount() {
    return new ethers.Wallet(getEnvVariable("ACCOUNT_PRIVATE_KEY"), getProvider());
};

function getContract(contractName, hre) {
    const account = getAccount();
    return getContractAt(hre, contractName, getEnvVariable("CONTRACT_DEPLOY_ADDRESS"), account);
}

module.exports = {
    getEnvVariable,
    getProvider,
    getAccount,
    getContract,
};
