sudo apt update && sudo apt install curl jq htop -y
echo
echo "Press Ctrl + C to exit if you need more time to review the information below:"
echo
read -p "Enter node moniker: " MONIKER
read -p "Enter ETH address to receive/claim rewards: " REWARDS_ADDRESS
read -p "Enter validator private key: " PRIVATE_KEY
rm -rf $HOME/.elixir
mkdir $HOME/.elixir && cd $HOME/.elixir
sudo tee $HOME/.elixir/validator-mainnet.env > /dev/null <<EOF
ENV=prod
STRATEGY_EXECUTOR_DISPLAY_NAME=$MONIKER
STRATEGY_EXECUTOR_BENEFICIARY=$REWARDS_ADDRESS
SIGNER_PRIVATE_KEY=$PRIVATE_KEY
EOF
docker pull elixirprotocol/validator --platform linux/amd64
docker run -d \
  --env-file $HOME/.elixir/validator-mainnet.env \
  --platform linux/amd64 \
  --name elixir-mainnet \
  --restart unless-stopped \
  -p 27690:17690 \
  elixirprotocol/validator