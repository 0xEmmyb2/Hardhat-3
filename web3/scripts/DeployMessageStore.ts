import { network } from "hardhat";


async function main() {
    const { viem } = await network.connect();

    const feedback = await viem.deployContract("MessageStore", [message] {
         message  = 
    })
}