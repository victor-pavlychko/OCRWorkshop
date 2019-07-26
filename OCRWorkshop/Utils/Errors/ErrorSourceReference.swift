//
//  ErrorSourceReference.swift
//  GenericError
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

public struct ErrorSourceReference {
    public let file: StaticString
    public let line: Int
    public let function: StaticString

    public var location: String {
        return "\(file):\(line)"
    }

    public init(file: StaticString = #file, line: Int = #line, function: StaticString = #function) {
        self.file = file
        self.line = line
        self.function = function
    }
}

extension ErrorSourceReference: CustomStringConvertible {
    public var description: String {
        return "`\(function)` at `\(location)`"
    }
}
