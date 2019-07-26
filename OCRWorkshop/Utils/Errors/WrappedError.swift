//
//  WrappedError.swift
//  GenericError
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

public class WrappedError<UnderlyingError>: GenericError where UnderlyingError: Error {
    public let underlyingError: UnderlyingError

    public init(_ underlyingError: UnderlyingError, message: String? = nil, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        self.underlyingError = underlyingError
        super.init(message, file: file, line: line, function: function)
    }

    override public var debugDescription: String {
        let lines: [String] = [
            super.debugDescription,
            "",
            "Underlying Error:",
            underlyingError.localizedDescription
                .components(separatedBy: .newlines)
                .map { "> \($0)" }
                .joined(separator: "\n")
        ]

        return lines
            .compactMap { $0 }
            .joined(separator: "\n")
    }
}

extension Error {
    public func wrapWithContext(_ message: String? = nil, file: StaticString = #file, line: Int = #line, function: StaticString = #function) -> Error {
        return WrappedError(self, message: message, file: file, line: line, function: function)
    }
}

public func wrapError<R>(_ block: @autoclosure () throws -> R) throws -> R {
    do {
        return try block()
    } catch {
        throw error.wrapWithContext()
    }
}
