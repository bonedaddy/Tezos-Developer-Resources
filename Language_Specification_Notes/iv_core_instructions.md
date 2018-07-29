# Core Instructions

The followin notes are taken from section `IV - Core Instructions` of the michelson formal language specification.

## Control Structures

* `FAILWITH` - Explicity abort the current program
  * `'a :: _ -> _`
  * Remember from section 2 that `'a` is a type variable
  * This special instruction aborts the current program, exposing the top of the stack in its error message (first rule below)
  * Output is useless since all subsequent instructions will simply ignore their usual semantics to propogate the failure up to the main result (second rule below)
  * `> FAILWITH / a : _ => [FAILED]`
  * `> _ / [FAILED] => [FAILED]`

* `{ I ; C }` - Sequence

  ``` C++

  'A - > 'C
  iff I :: [ 'A -> 'B ]
      C :: [ 'B -> 'C ]
  ```

  ``` Ocaml

  > I ; C / SA => SC
      where I / SA => SB
      and C / SB =>SC
  ```

* `IF bt bf` - Condition branching

``` Ocaml
:: bool : 'A -> -B
  iff bt :: [ 'A -> 'B ]
      bt :: [ 'A -> 'B]

> IF bt bf / True : S => bt / S
> IF bt bf / False : S => bt / S
```