#! /bin/bash
  
# Please answer yes to any of the prompts
# Modified the script listed here http://tezos.gitlab.io/master/introduction/howtoget.html#build-from-sources as it was out of date
# Built binaries will be in the root directory of the git repo that we clone
# Tested On:
#  -> Ubuntu 18.04
#  -> Ubuntu 16.04
#  -> Pop!_OS 18.04

## Check for ubuntu 16.04 an dinstall bubble wrap
DISTRIB_RELEASE=$(grep "DISTRIB_RELEASE" /etc/lsb-release | awk -F '=' '{print $2}')
TEZOS_NETWORK="betanet"

if [[ "$DISTRIB_RELEASE" == "16.04" ]]; then
    echo "[INFO] ubuntu 16.04 detected"
    echo "[INFO] Installing bubblewrap ppa"
    sudo add-apt-repository ppa:ansible/bubblewrap -y
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update -y
    echo "[INFO] Installing 16.04 dependencies"
    sudo apt install -y libev-dev libgmp-dev pkg-config wget make gcc m4 g++ aspcud curl bzip2 rsync libhidapi-dev
fi

echo "[INFO] installing general dependencies"
sudo apt install -y git m4 build-essential patch unzip bubblewrap wget
echo "[INFO] downloading opam rc4"
wget https://github.com/ocaml/opam/releases/download/2.0.0-rc4/opam-2.0.0-rc4-x86_64-linux
sudo cp opam-*linux /usr/local/bin/opam
sudo chmod a+x /usr/local/bin/opam
echo "[INFO] downloading tezos"
git clone https://gitlab.com/tezos/tezos.git
cd tezos
echo "[INFO] checking out branch $TEZOS_NETWORK"
git checkout "$TEZOS_NETWORK"
opam init --bare
echo "[INFO] building dependencies"
make build-deps
eval $(opam env)
echo "[INFO] building tezos"
make
export PATH=~/tezos:$PATH
source ./src/bin_client/bash-completion.sh
export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y