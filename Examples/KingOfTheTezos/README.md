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
  players = (Map [(tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt, 100tz)])
}
```

#### Test 3 - Mock a deployment

parameter `tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt`

```javascript
{
  creator =  tz1LRhs3uaaFAXfHJiC5fdEjbmF3MFxdGgUw;
  king = tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt;
  king_address = KT1BEqzn5Wx8uJrZNvuS9DVHmLvG9td3fDLi;
  initial_throne = 10001.2tz;
  throne = 0tz;
  greetings_tribute = 0.1tz;
  passings_tribute = 1tz;
  players = (Map [(tz1Yju7jmmsaUiG9qQLoYv35v5pHgnWoLWbt, 0tz)])
}
```
