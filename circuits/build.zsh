#!/bin/zsh

#brew install coreutils

#zsh ../build.zsh 

if [ -n "$ZSH_VERSION" ]; then
    echo "Script is running in Zsh"
else
    echo "Please run this script in Zsh. \"zsh build.zsh\""
    exit 1
fi
source ~/.zshrc
nvm install v18.19.0
nvm use v18.19.0

time circom src/multiplier2.circom --r1cs --wasm --sym --c

start_time=$(gdate +%s.%N)
cd multiplier2_js && time node generate_witness.js multiplier2.wasm ../src/input.json ../witness.wtns


cd ..
time snarkjs groth16 setup multiplier2.r1cs ../../tau/12/pot12_final.ptau multiplier2_0000.zkey 

echo "4668c3e48205b158d4a40035b2260b4678137c5209156f6fd7ab8a42c9848648" | time snarkjs zkey contribute multiplier2_0000.zkey multiplier2_0001.zkey --name="1st Contributor Name" -v

time snarkjs zkey export verificationkey multiplier2_0001.zkey verification_key.json

echo "prove..."
time snarkjs groth16 prove multiplier2_0001.zkey witness.wtns proof.json public.json
end_time=$(gdate +%s.%N)
elapsed_time=$((end_time - start_time))
echo "\n==== Elapsed time: $elapsed_time seconds ====\n"

echo "verify..."
time snarkjs groth16 verify verification_key.json public.json proof.json