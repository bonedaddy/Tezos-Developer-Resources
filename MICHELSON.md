# Type Notations

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

# Meta Type Variables

Meta type variables live only at the specification level, used to express consistency between parts of the program.

The typing rule for the `IF` construct introduces meta variables that express both branches have to have the same type.

Annotations for meta type variables are as follows:

* `'a` for a type variable
* `'A` for a stack type variable
* `_` for an anonymous type or stack type variable