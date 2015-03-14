//  Copyright (c) 2015 Neil Pankey. All rights reserved.

import XCTest
import Equality

final class EqualityTests: XCTestCase {
    func testEmpty() {
        XCTAssert(EmptySequence<Int>() == [])
        XCTAssert(Set<Character>() == [])
        XCTAssert([] == EmptySequence<Box<Bool>>())
        XCTAssert(EmptySequence() == Set<String>())
        XCTAssert(EmptySequence() == TestSequence<Int>())
    }

    func testCommutativity() {
        XCTAssert(Set([42]) == TestSequence(42))
        XCTAssert(TestSequence(42) == Set([42]))

        XCTAssert(["foo", "bar", "baz"] == TestSequence("foo", "bar", "baz"))
        XCTAssert(TestSequence("foo", "bar", "baz") == ["foo", "bar", "baz"])

        XCTAssert("Hello" == TestSequence("H", "e", "l", "l", "o"))
        XCTAssert(TestSequence<Character>("H", "e", "l", "l", "o") == "Hello")

        XCTAssert(TestSequence(Box(1)) == [Box(1)])
        XCTAssert([Box(1)] == TestSequence(Box(1)))
    }

    func testInequality() {
        XCTAssert([] != TestSequence(1))
        XCTAssert(EmptySequence() != TestSequence("Hello", "World"))
        XCTAssert(TestSequence(1, 2, 3) != TestSequence(1, 2, 4))
        XCTAssert(TestSequence(0, 1, 2) != TestSequence(1, 1, 2))
        XCTAssert(TestSequence(1, 2, 3) != TestSequence(1, 3, 3))
        XCTAssert(TestSequence(Box("asdf")) != TestSequence(Box("fdsa")))
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

struct TestSequence<T> : SequenceType {
    var values: [T]
    init(_ values: T...) {
        self.values = values
    }

    func generate() -> Array<T>.Generator {
        return values.generate()
    }
}
