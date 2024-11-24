#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

curl -s bash <(curl -s https://raw.githubusercontent.com/CryptoAirdropHindi/Crypto-Airdrop-Hindi-Guides/refs/heads/main/logo.sh) | bash
echo "Starting Auto Install Nodes Multiple Network"
sleep 5

# Check Linux architecture
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/x64/multipleforlinux.tar"
elif [[ "$ARCH" == "aarch64" ]]; then
    CLIENT_URL="https://cdn.app.multiple.cc/client/linux/arm64/multipleforlinux.tar"
else
    echo -e "${RED}Unsupported architecture: $ARCH${NC}"
    exit 1
fi

echo -e "${GREEN}Downloading client from $CLIENT_URL...${NC}"
wget $CLIENT_URL -O multipleforlinux.tar

echo -e "${GREEN}Extracting installation package...${NC}"
tar -xvf multipleforlinux.tar

# Navigate into the extracted directory
cd multipleforlinux

echo -e "${GREEN}Setting required permissions...${NC}"
chmod +x multiple-cli
chmod +x multiple-node

# Configure required parameters
echo -e "${GREEN}Configuring PATH...${NC}"
echo "PATH=\$PATH:$(pwd)" >> ~/.bashrc
source ~/.bashrc

# Set permissions for the directory
echo -e "${GREEN}Setting permissions for the directory...${NC}"
chmod -R 777 .

# Prompt for IDENTIFIER and PIN
read -p "Enter your IDENTIFIER: " IDENTIFIER
read -p "Enter your PIN: " PIN

# Run the program
echo -e "${GREEN}Running the program...${NC}"
nohup ./multiple-node > output.log 2>&1 &

# Bind unique account identifier
echo -e "${GREEN}Binding account with identifier and PIN...${NC}"
./multiple-cli bind --bandwidth-download 100 --identifier "$IDENTIFIER" --pin "$PIN" --storage 200 --bandwidth-upload 100

echo -e "${GREEN}Process completed.${NC}"

# Step 8: Perform other operations if necessary
echo -e "${YELLOW}You can perform other operations if necessary. Use the --help option to view specific commands for logs.${NC}"
