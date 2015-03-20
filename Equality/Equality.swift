//  Copyright (c) 2015 Neil Pankey. All rights reserved.

/// An equality function over two sequences. Returns true iff both contain the same number of values in the same order.
///
/// Unlike the Swift stdlib version of `equal` this doesn't require elements of both sequences to be the same.
public func equal<S0: SequenceType, S1: SequenceType>(lhs: S0, rhs: S1, @noescape compare: (S0.Generator.Element, S1.Generator.Element) -> Bool) -> Bool {
    var leftGenerator = lhs.generate()
    var rightGenerator = rhs.generate()

    var leftElement = leftGenerator.next()
    var rightElement = rightGenerator.next()

    while let leftValue = leftElement, let rightValue = rightElement
        where compare(leftValue, rightValue) {
            leftElement = leftGenerator.next()
            rightElement = rightGenerator.next()
    }

    return leftElement == nil && rightElement == nil;
}

/// An equality function over two sequence. Returns true iff both contain the same number of values in the same order.
///
/// Unlike the Swift stdlib version of `equal` this doesn't require elements of both sequences to be the same.
///
/// This overload supports currying the comparator for easier creation of binary equality functions.
public func equal<S0: SequenceType, S1: SequenceType>(@noescape compare: (S0.Generator.Element, S1.Generator.Element) -> Bool)(_ lhs: S0, _ rhs: S1) -> Bool {
    return Equality.equal(lhs, rhs, compare)
}

/// Defines an equality operator for arbitrary sequences of equatable elements.
///
/// In practice this is most useful in tests for asserting equality of custom sequences against some reference collection:
///
///     assert(CustomCollection(1, 2, 3) == [1, 2, 3])
public func == <S0: SequenceType, S1: SequenceType where S0.Generator.Element == S1.Generator.Element, S0.Generator.Element: Equatable> (lhs: S0, rhs: S1) -> Bool {
    return Equality.equal(lhs, rhs) { $0 == $1 }
}

/// Defines an inequality operator for arbitrary sequences of equatable elements
///
/// In practice this is most useful in tests for asserting inequality of custom sequences against some reference collection:
///
///     assert(CustomCollection(1, 2, 3) != [1, 2, 3])
public func != <S0: SequenceType, S1: SequenceType where S0.Generator.Element == S1.Generator.Element, S0.Generator.Element: Equatable> (lhs: S0, rhs: S1) -> Bool {
    return !(lhs == rhs)
}
