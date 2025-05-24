-include .env

build:
	forge build

test:
	forge test
test-sepolia:
	forge test --rpc-url "$(SEPOLIA_RPC_URL)"
test-mainnet:
	forge test --rpc-url "$(MAINNET_RPC_URL)"

# for deploying to local chain
deploy:
	forge script DeployCreatorArmourNFT --rpc-url http://127.0.0.1:8545  --broadcast --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80


deploy-sepolia:
	forge script DeployCreatorArmourNFT --rpc-url "$(SEPOLIA_RPC_URL)" --broadcast --account "$(ACCOUNT)" --verify --etherscan-api-key "$(ETHERSCAN_API_KEY)" 

deploy-mainnet:
	forge script DeployCreatorArmourNFT --rpc-url "$(MAINNET_RPC_URL)" --broadcast --account "$(ACCOUNT)" --verify --etherscan-api-key "$(ETHERSCAN_API_KEY)"

clean:
	forge clean