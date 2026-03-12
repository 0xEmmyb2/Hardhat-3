import { HardhatUserConfig } from "hardhat/config";
import hardhatViem from "@nomicfoundation/hardhat-viem";

const config: HardhatUserConfig = {
  plugins: [hardhatViem],
  solidity: "0.8.28",
  networks: {
    localhost: {
      type: "http",
      url: "http://127.0.0.1:8545",
    },
  },
};

export default config;