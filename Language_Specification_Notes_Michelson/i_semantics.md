# Semantics

The following notes are taken from section `I - Semantics` of the formal language specification

The michelson interpreter is a pure function. It builds a result stack from the elements of an initial stack, without affecting its environment.

This semantic is given in what is called a *big step form, a symbolic definition of a recursive reference interpeter*.

This definitions takes the form of a list of rules that cover all possible inputs of the interpreter (program, and stack) while describing the computation of the corresponding result stacks

## Rules - Form And Selection

``` Ocaml
> (syntax pattern) / (initial stack pattern) => (result stack pattern)
    iff (conditions)
    where (recursions)
    and (more recursions)
```

The left hand side of the `=>` sign is used for selecting the rule. Given a program and an initial stack, one and only one rule can be selected using the following process:

* First, the toplevel of the program must match the syntax pattern.
  * This is simple since there is only a few non trivial patterns to deal with instruction sequences, while the rest are made of trivila patterns that match on specific instruction
* The initial stack must match the initial stack pattern
* Some rules add conditions over values in the stack that follow the `iff` keyword
  * Sometimes, several rules may apply in a given content, and if this is true, the one that appears first in the specification is to be selected
  * If no rule applies, the resut is equivalent to the one for the explicit `FAILWITH` instruction however this does not happen on well-typed programs

The right hand side of the `=>` sign describes the result of the interpreter if the rule applies. It consists in a stack pattern whose parts are constants, or elements of the context (program and initial stack) that have been named on the left hand side of the `=>` sign.

## Recurisve Rules (big step form)

Sometimes the result of an interpreting program is also derived from the result of interpreting another one (such as conditionals, or function calls). 

These rules contain a clause of the following form:
`where (intermediate program) / (intermediate stack) => (partial result)`

This means that the rule applies in case interpreting the intermediate state on the left gives the pattern on the right.

The left hand side of the `=>` is constructed from elements of the initial state or other partial results, and the right identify parts that can be used to build the result stack of the rule.

If the partial result pattern does not mathc the result of the interpretation, then the result of the whole rule is equivalent to the one for hte explicit `FAILWITH` instruction. This should not happen on well typed programs.

## Format of Patterns

Code patterns are one of the following forms:

* `INSTR` (an uppercase identifier) is a simple instruction such as `DROP`
* `INSTR (arg) ...` is a compound instruction, whose arguments can be code, data, or type patterns such as `PUSH nat 3`
* `{ (instr) ; ... }` is a possible empty sequence of instructions such as `IF { SWAP ; DROP } {DROP }`
  * Nested sequences can drop the braces
* `name` is a pattern that matches any program, and names of the matched program that can be used to build the reuslt
* `_` is a pattern that matches any instructions

Stack patterns are one of the following forms

* `[FAILED]` is the special failed state
* `[]` is the empty stack
* `(top) : (rest)` is a stock whose top element is matched by the data pattern `(top)` on the left, and whose remaining elements matched by the stack pattern `(rest)
  * `x : y : rest`
* `name` is a pattern that matches any stack and names in order to use it to build the result
* `_` is a pattern that matches any stack

Data patterns are one of the following forms

* integers/natural number literals such as `3`
* string literals such as `contents`
* raw byte sequence literals such as `0xABCDEF42`
* `Tag` (capitalized) is a symbol constant such as `Unit`, `True`, `False`
* `(Tag (arg) ...)` tagged constructed data such as `(Pair 3 4)`
* a code pattern for first class code values
* `name` to name a value in order to use it to build the reuslt
* `_` to match any value

Michelson does not let hte progammer introduce its own types. It is important to note that syntax used in the specification, may not match the concrete syntax in section IX. In particular, some instructed are annotated with types that are not present in the concrete language due to their synthesis by the typechecker.

## Shortcuts

Sometimes we may want to write and think in progrma rewriting than in big step semnatics. In this case, and when both are equivalentswe can write rules in the form of

``` Ocaml
p / S => S''
where p' / S' => S''
```

With the following shortcut
`p / S => p' / S'`