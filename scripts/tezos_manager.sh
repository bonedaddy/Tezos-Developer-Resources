#! /bin/bash

# Script to assist in managing a tezos node
# Author: Postables - RTrade Technologies <postables@rtradetechnologies.com>
# Tested On:
#   -> Ubuntu 16.04 LTS

# This disables whether or not the network warning is displayed
DISCLAIMER_BYPASS="Y"
# If unset, no rpc port will be opened up when the node is ran
RPC_ADDR="127.0.0.1:8732"
# the tezos node path 
TEZOS_NODE_PATH="/home/rtrade/.tezos-node"
# tezos node key name
TEZOS_NODE_KEY_NAME="rtrade"
# points to the tezos config file
TEZOS_NODE_CONFIG_FILE="$TEZOS_NODE_PATH/config.json"
# log dir
LOG_DIR="/home/rtrade"

if [[ "$DISCLAIMER_BYPASS" == "Y" ]]; then
    export TEZOS_CLIENT_UNSAFE_DISABLE_DISCLAIMER=Y
fi

# used to list the protocols the node understands
list_protocols() {
    tezos-client list understood protocols
}

# used to start a node
run_node() {
    if [[ "$RPC_ADDR" != "" ]]; then
        echo "Running node, hit CTRL+C to exit"
        nohup tezos-node run --rpc-addr="$RPC_ADDR" --data-dir="$TEZOS_NODE_PATH" --config-file="$TEZOS_NODE_CONFIG_FILE"
    else
        echo "Running node, hit CTRL+C to exit"
        nohup tezos-node run --data-dir="$TEZOS_NODE_PATH" --config-file="$TEZOS_NODE_CONFIG_FILE"
    fi

}

run_endorser() {
    nohup tezos-endorser-002-PsYLVpVv run "$TEZOS_NODE_KEY_NAME" 2>&1 | tee --append "$LOG_DIR/tezos-endorser.log"
}

run_accuser() {
    tezos-accuser-002-PsYLVpVv run 2>&1 | tee --append "$LOG_DIR/tezos-accuser.log"
}

baker_start() {
    nohup tezos-baker-002-PsYLVpVv run with local node "$TEZOS_NODE_PATH" "$TEZOS_NODE_KEY_NAME" 2>&1 | tee --append "$LOG_DIR/tezos-baker.log"
}

boot_strapped() {
    tezos-client bootstrapped
}

activate_account() {
    echo "enter account name"
    read -r ACCOUNT_NAME
    echo "enter path to json key file"
    read -r KEY_FILE
    tezos-client activate account "$ACCOUNT_NAME" with "$KEY_FILE"
}

originate_account_and_delegate() {
    echo "enter account name"
    read -r ACCOUNT_NAME
    ORIGINATED_ACCOUNT_NAME="$ACCOUNT_NAME"-originated
    echo "enter balance to delegate"
    tezos-client originate account "$ORIGINATED_ACCOUNT_NAME" for "$ACCOUNT_NAME" transferring "$BALANCE" from "$ACCOUNT_NAME" --delegate "$TEZOS_NODE_KEY_NAME" --delegatable
}

transfer_tokens() {
    echo "enter account to transfer from"
    read -r SOURCE_ACCOUNT
    echo "enter account to transfer to"
    read -r DESTINATION_ACCOUNT
    echo "enter amount to send"
    read -r AMOUNT
    echo "enter fee"
    read -r FEE
    tezos-client transfer "$AMOUNT" from "$SOURCE_ACCOUNT" to "$DESTINATION_ACCOUNT" --fee "$FEE"
}

get_balance() {
    echo "enter account to get balance for"
    read -r ACCOUNT
    tezos-client get balance for "$ACCOUNT"
}

case "$1" in

    list-protocols)
        list_protocols
        ;;
    lp)
        list_protocols
        ;;
    run-node)
        run_node
        ;;
    rn)
        run_node
        ;;
    bootstrapped)
        boot_strapped
        ;;
    bp)
        boot_strapped
        ;;
    baker-start)
        baker_start
        ;;
    bs)
        baker_start
        ;;
    activate-account)
        activate_account
        ;;
    aa)
        activate_account
        ;;
    originate-account)
        originate_and_delegate_account
        ;;
    oa)
        originate_and_delegate_account
        ;;
    run-endorser)
        run_endorser
        ;;
    re)
        run_endorser
        ;;
    run-accuser)
        run_accuser
        ;;
    ra)
        run_accuser
        ;;
    transfer-tokens)
        transfer_tokens
        ;;
    tt)
        transfer_tokens
        ;;
    get-balance)
        get_balance
        ;;
    gb)
        get_balance
        ;;
    *)
        echo "Invalid invocation, $1 is not a valid command"
        echo ""
        echo "./tezos_manager.sh [list-protocols | run-node | bootstrapped | baker-start | activate-account | originate-account | run-endorser | run-accuser | transfer-tokens | get-balance]"
        echo ""
        echo "list-protocols, lp - list understood protocols"
        echo "run-node, rn - used to launch a tezos node"
        echo "bootstrapped, bp - used to check if the node is bootstrapped"
        echo "baker-start, bs - used to start the baker"
        echo "activate-account, aa - used to activate a new account"
        echo "originate-account, oa - used to originate a new account"
        echo "run-endorser, re - run an endorser"
        echo "run-accuser, ra - run an accuser"
        echo "transfer-tokens, tt - transfer tokens"
        echo "get-balanace, gb - get balance"
        exit 1

esac