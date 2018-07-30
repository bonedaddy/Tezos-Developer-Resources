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

* `DROP` - Drop the top

```Ocaml
:: _ : 'A -> 'A

> DROP / _ : S => S
```

* `DUP` - Duplicate the top of the stack

```Ocaml
:: 'a : 'A -> 'a : 'a : 'A

> DUP / x : S => x : x : S
```

* `SWAP` - Exchange the top two elements of the stack

```Ocaml
:: 'a : 'b : 'A -> 'b : 'a : 'A

> SWAP / x : y : S => y : x : S
```

* `PUSH 'a x` - Push a constant value of a given type onto the stack

```Ocaml
:: 'A -> 'a : 'A
  iff x :: 'a

> PUSH 'a x / S => x : S
```

* `UNIT` - Push a unit value onto the stack

```Ocaml
:: 'A -> unit : 'A

> UNIT / S => Unit : S
```

* `LAMBDA 'a 'b code` - Push a lambda with given parameter and return types onto the stack

```Ocaml
:: 'A -> (lambda 'a 'b) : 'A

> LAMBDA _ _ code / S => code : S
```

## Generic Comparisons

Comparisons will only work a class of types that we call comparable. A `COMPARE` operation is defined in an ad hoc manner for each comparable type, but the result of a compare is always an `int` can can in turn be checked. 

The result of `COMPARE` is `0` if the top two elements of the stack are equal, negative if the first element in the stack is less than the second, and positive if the second element is less than the first.

* `EQ` - Checks that the top of the stack Equals zero

```Ocaml

:: int : 'S -> bool : 'S

> EQ / 0 : S => True : S
> EQ / v : S => False : S
  iff v <> 0
```

* `NEQ` - Checks that the top of the stack does not equal zero

``Ocaml
:: int : 'S   ->   bool : 'S

> NEQ / 0 : S  =>  False : S
> NEQ / v : S  =>  True : S
    iff v <> 0
```

* `LT` - Checks that the top of the stack is less than zero

```Ocaml
:: int : 'S   ->   bool : 'S

> LT / v : S  =>  True : S
    iff  v < 0
> LT / v : S  =>  False : S
    iff v >= 0
```

* `GT` - Checks that the top of the stack is greater than zero

```Ocaml
:: int : 'S   ->   bool : 'S

> GT / v : S  =>  C / True : S
    iff  v > 0
> GT / v : S  =>  C / False : S
    iff v <= 0
```

* `LE` - Checks that the top of the stack is less than or equal to zero

```Ocaml
:: int : 'S   ->   bool : 'S

> LE / v : S  =>  True : S
    iff  v <= 0
> LE / v : S  =>  False : S
    iff v > 0
```

* `GE` - Checks that the top of hte stack is greater than or equal to zero

```Ocaml
:: int : 'S   ->   bool : 'S

> GE / v : S  =>  True : S
    iff  v >= 0
> GE / v : S  =>  False : S
    iff v < 0
```