//  Copyright (c) 2015 Neil Pankey. All rights reserved.

public func == <S0: SequenceType, S1: SequenceType, E: Equatable where S0.Generator.Element == E, S1.Generator.Element == E> (seq0: S0, seq1: S1) -> Bool {
    var gen0 = seq0.generate()
    var gen1 = seq1.generate()

    var elem0 = gen0.next()
    var elem1 = gen1.next()

    while let val0 = elem0, let val1 = elem1 where val0 == val1 {
        elem0 = gen0.next()
        elem1 = gen1.next()
    }

    return elem0 == nil && elem1 == nil;
}
