# Contract Format

All contracts have the following form

```Ocaml

[%%version VERSION]

<... local declarations ...>

let%init storage
    (x : TYPE)
    (x : TYPE)
    ... =
    BODY

let%entry main
    (parameter : TYPE)
    (storage : TYPE) =
    BODY
```

The `main` function is the default entry point for a contract. `let%entry` is the construct used to declare entry points (only one entry point). The declaration takes two parameters with names `parameter` and `storage` which are the arguments ot the function. Return type of the function must alos have a type annotation

Contracts always return a pair `(operations, storage)` where `operations` is a list of internal operations to perform after execution of the contract, and `storage` is the final state of the contract after the call.

## Records

Record types can be declared as well, which consist of a minimum of 2 values. They are compiled as tuples

```Ocaml

type storage = {
    x : string;
    y : int;
}
```

You can also create them inside programs

```Ocaml

let r = { x = "foo"; y = 3 } in
r.x
```

Deep record creation is also possible

```Ocaml

let r1 = { x = 1; y = { z = 3 } } in
let r2 = r1.y.z <- 4 in
...
```