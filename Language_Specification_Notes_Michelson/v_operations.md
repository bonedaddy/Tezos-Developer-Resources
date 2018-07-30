# Operations

The following notes are taken from section `V - Operations` from the tezos docuentation

* `OR`

```Ocaml
:: bool : bool : 'S -> bool : 'S

> OR / x : y : S => (x | y) : S
```

* `AND`

```Ocaml
:: bool : bool : 'S -> bool : 'S

> AND / x : y : S => (x & y): S
```

* `XOR`

```Ocaml
:: bool : bool : 'S -> bool : 'S

> XOR / x : y : S => (x ^ y) : S
```

* `NOT`

```Ocaml
:: bool : 'S -> bool : 'S

> NOT / x : S => ~X : S
```