# Установка ноды Elixir

## Требования к серверу
Минимальные ресуры: 2 CPU / 4 RAM
Рекомендуемые ресуры: 4 CPU / 8 RAM

## Предварительные шаги
1. Создайте новый тестовый кошелек (**Кошелек А**)
Это будет ваш тестовый кошелек, который будет использоваться для управления транзакциями ноды.

2. Определите основной кошелек (**Кошелек Б**)
Это будет основной кошелек, на который будут выводиться средства.

3. Купите тестовый токен Sepolia на сайте [Testnet Bridge](testnetbridge.com/sepolia).
Используя **Кошелек Б**, купите немного тестового токена Sepolia (достаточно 0.001 ETH).

4. Придумайте псевдоним для вашей ноды (MONIKER).

## Установка ноды
В процессе установки вам нужно будет указать:
Псевдоним ноды (MONIKER) — ваш выбранный псевдоним для ноды.
Адрес основного кошелька (**Кошелек Б**).
Приватный ключ тестового кошелька (**Кошелек А**).

Установите ноду, используя код ниже.

```bash
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
```

## Завершение настройки
Перейдите на сайт [elixir Testnet](testnet-3.elixir.xyz).
Убедитесь, что вы подключены к сети Sepolia и используете Кошелек Б.
В сети Sepolia сминтите 1000 MOCK токенов на свой основной кошелек (Кошелек Б).
Застейкайте 1000 MOCK токенов на этом же сайте.
Делегируйте свои застейканные токены валидатору (введите адрес **кошелька А**).
