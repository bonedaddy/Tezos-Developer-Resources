#! /bin/bash
  
# Please answer yes to any of the prompts
# Modified the script listed here http://tezos.gitlab.io/master/introduction/howtoget.html#build-from-sources as it was out of date
# Built binaries will be in the root directory of the git repo that we clone
# Tested On:
#  -> Ubuntu 18.04

sudo apt install -y git m4 build-essential patch unzip bubblewrap wget
wget https://github.com/ocaml/opam/releases/download/2.0.0-rc3/opam-2.0.0-rc3-x86_64-linux
sudo cp opam-*linux /usr/local/bin/opam
sudo chmod a+x /usr/local/bin/opam
git clone https://gitlab.com/tezos/tezos.git
cd tezos
git checkout betanet
opam init --bare
make build-deps
eval $(opam env)
make
export PATH=~/tezos:$PATH
source ./src/bin_client/bash-completion.sh
export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y
