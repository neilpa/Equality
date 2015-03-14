//  Copyright (c) 2015 Neil Pankey. All rights reserved.

import XCTest
import Equality

final class EqualityTests: XCTestCase {
    func testEmpty() {
        XCTAssert(EmptySequence<Int>() == [])
        XCTAssert(Set<Character>() == [])

        XCTAssert([] == EmptySequence<Box<Bool>>())
        XCTAssert([] == Set<String>())
    }
}

// MARK: Fixtures

class Box<T: Equatable> : Equatable {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}

func == <T>(lhs: Box<T>, rhs: Box<T>) -> Bool {
    return lhs.value == rhs.value
}

struct EmptySequence<T> : SequenceType {
    func generate() -> GeneratorOf<T> {
        return GeneratorOf { nil }
    }
}
