//
//  GenericError.swift
//  GenericError
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

public class GenericError: Error, CustomStringConvertible, CustomDebugStringConvertible, LocalizedError {
    public let message: String?
    public let sourceReference: ErrorSourceReference
    public let callStackSymbols: ErrorCallStackSymbols

    public init(_ message: String? = nil, file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        self.message = message
        self.sourceReference = .init(file: file, line: line, function: function)
        self.callStackSymbols = .init()
    }

    public var description: String {
        let message = self.message ?? "Error"
        return "\(message) in \(sourceReference)"
    }

    public var debugDescription: String {
        var lines: [String] = [
            description,
        ]

        if !callStackSymbols.callStackSymbols.isEmpty {
            lines.append(contentsOf: [
                "",
                "Call Stack Symbols:",
                callStackSymbols.description,
            ])
        }

        return lines
            .compactMap { $0 }
            .joined(separator: "\n")
    }

    public var errorDescription: String? {
        return debugDescription
    }
}
