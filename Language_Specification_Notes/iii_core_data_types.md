# Core Data Types And Notations

The following are notes taken from section III of the formal language specification

## Core Data Types

* `string`, `nat`, `int`, `bytes`
  * These are the core primitive constant types
* `bool`
  * Type for boolean values who are `True` and `False
* `unit`
  * Type whose only value is `Unit` which is used as a placeholder when some result or parameter is not necessary
  * This is useful when the only goal of a contract is to update its storage
* `list (t)`
  * A single immutable linked list whose elements are of type `(t)`
  * `{}` denotes an empty list
  * `{ first ; ... }` also denotes an emtpy list
  * We use chevrons `{ head ; <tail> }` to denote subsequence of elements
* `pair (l) (r)` a pair of values `a` and `b` of types `(l)` and `(r)`
  * We write `(Pair a b)`
* `option (t)`
  * An optional value of type `(t)`
  * We write `None` or `(Some v)`
* `or (l) (r)`
  * A union of two types, holding a value `a` of type `(l)` or value `b` of type `(r)`
  * We write `(Left a)` or `(Right b)`
* `set (t)`
  * Immutable set of values with type `t`
  * We note a lists `{ item ; ... }`
  * Unique, and sorted elements
* `map (k) (t)`
  * Immutale maps from keys of type `(k)` with values of type `(t)`
  * We write `{ Elt key value ; ... }`
  * Sorted keys
* `big_map (k) (t)`
  * Lazy, deserialized maps with keys of type `(k)` with values of type `(t)`
  *We write `{ Elt key value ; ... }`
  * Sorted keys
  * Should be used if we intend to store large amounts of data in a map
  * Higher gas costs as data is deserialize
  * Single `big_map` per program
  Must appear on left hand side of a pair in the contract's storage