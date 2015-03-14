//  Copyright (c) 2015 Neil Pankey. All rights reserved.

/// Defines an equality operator for arbitrary sequences of equatable elements.
///
/// In practice this is most useful in tests for asserting equality of custom sequences against some reference collection (e.g. an array).
///
///     assert(CustomCollection(1, 2, 3) == [1, 2, 3])
public func == <S0: SequenceType, S1: SequenceType, E: Equatable where S0.Generator.Element == E, S1.Generator.Element == E> (lhs: S0, rhs: S1) -> Bool {
    var leftGenerator = lhs.generate()
    var rightGenerator = rhs.generate()

    var leftElement = leftGenerator.next()
    var rightElement = rightGenerator.next()

    while let leftValue = leftElement, let rightValue = rightElement
        where rightValue == leftValue {
        leftElement = leftGenerator.next()
        rightElement = rightGenerator.next()
    }

    return leftElement == nil && rightElement == nil;
}

/// Defines an inequality operator for arbitrary sequences of equatable elements
public func != <S0: SequenceType, S1: SequenceType, E: Equatable where S0.Generator.Element == E, S1.Generator.Element == E> (lhs: S0, rhs: S1) -> Bool {
    return !(lhs == rhs)
}
