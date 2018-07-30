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