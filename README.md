# Tezos-Developer-Resources

This repository aims to serve as a collection of Tezos development resurces to assist developers in using the Tezos blockchain.

Tezos is partially built on the idea of community driven governance, and incentivization of community driven development. [Stephen Andrews](https://github.com/stephenandrews/) has done a lot of the Tezos community already and his donation address for XTZ is `tz1cLDXASgh48ntYmLqM3cqPEXmUtpJVVPma`

## Examples

### Liquidity

### Advancd Liquidity Examples

* `KingOfTheTezos.ml` is a liquidity version of King Of The Ether

### Basic Liquidity Examples

* `hello_world.ml` is a basic hello world in liquidity
* `string_set.ml` is a basic liquidity contract, allowing one to set a string value in storage
* `string_set_with_cost.ml` allows you to set a string in storage if you pay 10tz
* `multi_string_set.ml` allows you to set two strings in storage
* `multi_string_set_with_cost.ml` allows you to set two strings in storage, and the value of the transaction if you pay 10tz or more

### Michelson

* `hello_worldz.tz` - michelson version of the liquidity hello world contract

## Tutorials

* [contract a day](https://www.michelson-lang.com/contract-a-day.html#sec-1)
* [Getting Started With Tezos: first steps](https://martin.pospech.cz/post/getting_started_with_tezos/)
* [Optimizing Stack manipulation in Michelson](https://hackernoon.com/optimizing-stack-manipulation-in-michelson-31ba7ff11a3a)
* [Getting started with Liquidity: coinflip](https://martin.pospech.cz/post/getting_started_with_liquidity/)

## Resources

* [The Michelson Language](https://www.michelson-lang.com/)
* [language specification - Table Of Contents](https://doc.tzalpha.net/whitedoc/michelson.html#table-of-contents)
* [Ocaml and Michelson Resources](https://github.com/tezoscommunity/FAQ/wiki/OCaml-and-MIchelson-Resources)
* [Developer Documentation](https://doc.tzalpha.net/index.html)
* [Baking Information](https://medium.com/tezos/its-a-baker-s-life-for-me-c214971201e1)
* [Fi Documentation](https://fi-code.gitbooks.io/documentation/content/)

## Smart Contract Languages

* [Liquidity - High Level Language, Ocaml Syntax, Strict compilation with Michelson security restrictions](https://www.liquidity-lang.org/)
* [fi is a powerful, smart contract language for Tezos that compiles down to valid and verifiable Michelson code. fi is currently in early alpha stages, with the aim of release a complete alpha release soon](https://github.com/stephenandrews/fi)
* [Juvix PoC, possibly no updates in future](https://github.com/cwgoes/juvix)

## Liquidity Language

* [Try Liquidity](http://www.liquidity-lang.org/edit/)
* [Overview](https://github.com/OCamlPro/liquidity/blob/master/docs/liquidity.md)

## Tezos Dapps

* [Luckytz, the first public Tezos dapp](https://luckytez.github.io/)

### King Of The Tezos

Use this for testing in the online liquidity compiler

#### Test 1 - Throne warchest top up

Parameter `tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt`

```javascript
{
  creator =  tz1LRhs3uaaFAXfHJiC5fdEjbmF3MFxdGgUw;
  king = tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt;
  king_address = KT1BEqzn5Wx8uJrZNvuS9DVHmLvG9td3fDLi;
  initial_throne = 10tz;
  throne = 100tz;
  greetings_tribute = 0.1tz;
  passings_tribute = 1tz;
  players = (Map [(tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt, 100tz);(tz1UtyxbBMeNQmqXErRCUxi1CuppZ1nybBpF, 110.100000tz)])
}
```

#### Test 2 - Usurp

Parameter `tz1UtyxbBMeNQmqXErRCUxi1CuppZ1nybBpF`

```javascript
{
  creator =  tz1LRhs3uaaFAXfHJiC5fdEjbmF3MFxdGgUw;
  king = tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt;
  king_address = KT1GE2AZhazRxGsAjRVkQccHcB2pvANXQWd7;
  initial_throne = 10tz;
  throne = 100tz;
  greetings_tribute = 0.1tz;
  passings_tribute = 1tz;
  players = (Map [(tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt, 10tz)])
}
```

### Tools

Various tools for Tezos, categorized by language

### Golang

* [goTezos](https://github.com/DefinitelyNotAGoat/goTezos)

## Tezos API

### Golang Implementations

* [Postables](https://github.com/postables/TGo)

### Javascript Implementations

* [ezts](https://github.com/stephenandrews/eztz)

## Other Donation Addresses

* [Postables](https://github.com/postables) `tz1Wpefz7KdEkVf2hXGMRKYymVjML9Zpi1r7`
* [DefinitelyNotAGoat](https://github.com/DefinitelyNotAGoat/goTezos) `tz1hyaA2mLUQLqQo3TVk6cQHXDc7xoKcBSbN`