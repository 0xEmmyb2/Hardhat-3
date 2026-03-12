import  { network }  from "hardhat";
import { parseEther } from "viem";

async function main() {
    const { viem } = await network.connect();
  

    const unlockTime = BigInt(Math.floor(Date.now() / 1000) + 60);
    const lockedAmount = parseEther("0.001");  
    
    const lock = await viem.deployContract("Lock", [unlockTime], {
        value: lockedAmount,
    });

    console.log(`Lock deployed to: ${lock.address}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode =1;
})