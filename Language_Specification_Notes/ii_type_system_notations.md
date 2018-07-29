# Typing System and Notations

Notes taken from the section `II - Introduction to the type system and notations` of the Michelson language specification

## Type Notations

A stack type can be written as the following:

* `[]` denotes an empty stack
* `(top) : (rest)` denotes a stack with the first value of top `(top)` and queue with stack type `(rest)`

Intructions, programs, and primitives are also typed, written as:
`(type of stackbefore) -> (type of stack after)`

Type values in the stack are written as:

* `identifier` for a primitive data type such as `bool`
* `identifier (arg)` for parametric data types with a parameter type of `(args)` such as `list nat`
* `identifier (arg) ...` for a parametric data type with many parameters such as `map string int`
* `[ (type of stack before) -> (type of stack after) ]` for a code quotation such as `[ int : int : [] -> int : [] ]`
* `lambda (arg) (ret)` which is a shortcut for `[ (arg) : [] -> (ret) : [] ]`

## Meta Type Variables

Meta type variables live only at the specification level, used to express consistency between parts of the program.

The typing rule for the `IF` construct introduces meta variables that express both branches have to have the same type.

Annotations for meta type variables are as follows:

* `'a` for a type variable
* `'A` for a stack type variable
* `_` for an anonymous type or stack type variable

## Typing Rules

In tezos, the system is syntax directed, defining a single typing rule for each syntax construct. The typing rules *restrict the types of input stacks, and links the output type to the input type* and when needed links  both to subexpressions using meta type variables.

The following defines the form of typign rules:

``` C++
(syntax pattern)
:: (type of stack before) -> (type of stack after) [rule-name]
    iff (premises)
```

Premises are typing requirements over subprograms or values in the stack, both which have the form `(x) :: (type)` which means that the value `(x)` must have type `(type)`

Here we have a small type derivation which calculates `(x+5)*10` for input x, which is obtianed by instantiating typing rules for instructions `PUSH`, `ADD` and the sequence. During instantiation, we replace `iff` with `by`.

``` Ocaml
{ PUSH nat 5 ; ADD ; PUSH nat 10 ; SWAP ; MUL }
:: [ nat : [] -> nat : [] ]
   by { PUSH nat 5 ; ADD }
      :: [ nat : [] -> nat : [] ]
         by PUSH nat 5
            :: [ nat : [] -> nat : nat : [] ]
               by 5 :: nat
        and ADD
            :: [ nat : nat : [] -> nat : [] ]
  and { PUSH nat 10 ; SWAP ; MUL }
      :: [ nat : [] -> nat : [] ]
         by PUSH nat 10
            :: [ nat : [] -> nat : nat : [] ]
               by 10 :: nat
        and { SWAP ; MUL }
            :: [ nat : nat : [] -> nat : [] ]
               by SWAP
                  :: [ nat : nat : [] -> nat : nat : [] ]
              and MUL
                  :: [ nat : nat : [] -> nat : [] ]

```