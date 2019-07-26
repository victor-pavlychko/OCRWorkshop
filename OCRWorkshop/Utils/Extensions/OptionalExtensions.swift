//
//  OptionalExtensions.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/23/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

extension Optional {
    public func forceUnwrap(message: String = "Unexpected nil value in `\(#function)` at \(#file):\(#line)") -> Wrapped {
        switch self {
        case let .some(wrapped):
            return wrapped
        case .none:
            fatalError(message)
        }
    }

    public func unwrapped(or error: @autoclosure () -> Error = GenericError("Unexpected nil value", file: #file, line: #line, function: #function)) throws -> Wrapped {
        switch self {
        case let .some(wrapped):
            return wrapped
        case .none:
            throw error()
        }
    }
}

extension Optional where Wrapped: RangeReplaceableCollection {
    public func valueOrEmpty() -> Wrapped {
        return self ?? Wrapped()
    }
}
