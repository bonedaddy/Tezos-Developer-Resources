#! /bin/bash
  
# Please answer yes to any of the prompts
# Modified the script listed here http://tezos.gitlab.io/master/introduction/howtoget.html#build-from-sources as it was out of date
# Built binaries will be in the root directory of the git repo that we clone
# Tested On:
#  -> Ubuntu 18.04
#  -> Ubuntu 16.04
#  -> Pop!_OS 18.04

## Check for ubuntu 16.04 an dinstall bubble wrap
DISTRIB_RELEAS=$(grep "DISTRIB_RELEASE" /etc/lsb-release | awk -F '=' '{print $2}')
if [[ DISTRIB_RELEASE == "16.04" ]]; then
    sudo add-apt-repository ppa:ansible/bubblewrap -y
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update -y
    sudo apt install -y libev-dev libgmp-dev pkg-config wget make gcc m4 g++ aspcud curl bzip2 rsync libhidapi-dev
    # gett the following error on ubuntu 16.04
    # [ERROR] The compilation of conf-hidapi failed at "/home/rtrade/.opam/opam-init/hooks/sandbox.sh build pkg-config hidapi-libusb".
fi

sudo apt install -y git m4 build-essential patch unzip bubblewrap wget
wget https://github.com/ocaml/opam/releases/download/2.0.0-rc4/opam-2.-0.0-rc4-x86_64-linux
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
