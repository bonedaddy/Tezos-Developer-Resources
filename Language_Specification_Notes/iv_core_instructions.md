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

* `LOOP body` - A generic loop

``` Ocaml
:: bool : 'A -> 'A
  iff body :: [ 'A -> bool : 'A]
> LOOP body / True : S => body ; LOOP body / S
> LOOP body / False : S => S
```

* `LOOP_LEFT body` - A loop with an accumulator

```Ocaml
:: (or 'a 'b) : 'A   ->  'b : 'A
   iff   body :: [ 'a : 'A -> (or 'a 'b) : 'A ]

> LOOP_LEFT body / (Left a) : S  =>  body ; LOOP_LEFT body / a : S
> LOOP_LEFT body / (Right b) : S  =>  b : S
```

* `DIP code` - Runs code protecting the top of the stack

```Ocaml
:: 'b : 'A -> 'b : 'C
  iff code :: [ 'A -> 'C ]

> DIP code / x : S => x : S'
  where code / S => S'
```

* `EXEC` - Execute a function fom the stack

```Ocaml
:: 'a : lambda 'a 'b : 'C   ->   'b : 'C

> EXEC / a : f : S  =>  r : S
    where f / a : []  =>  r : []
```

## Stack Operations