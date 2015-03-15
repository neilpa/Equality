# Equality
Defines ad-hoc equality operators for arbitrary `SequenceType`s of `Equatable` elements of the same type. Seqeunces are considered equivalent iff they contain the same number of elements in the same order.

### Usage
In practice this is most useful when testing custom collections against some reference collection (e.g. an array).

```Swift
import Equality

let seq = CustomSequence(1, 2, 3)
assert(seq == [1, 2, 3])
```
