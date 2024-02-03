#!/bin/zsh

if [ -n "$ZSH_VERSION" ]; then
    echo "Script is running in Zsh"
else
    echo "Please run this script in Zsh. \"zsh build.zsh\""
    exit 1
fi
source ~/.zshrc
nvm install v18.19.0
nvm use v18.19.0

n=${1:-12}

echo n=${n}
snarkjs powersoftau new bn128 ${n} pot_0000.ptau -v

echo "4668c3e48205b158d4a40035b2260b4678137c5209156f6fd7ab8a42c9848648" |  snarkjs powersoftau contribute pot_0000.ptau pot_0001.ptau --name="First contribution" -v

snarkjs powersoftau prepare phase2 pot_0001.ptau pot_final.ptau -v