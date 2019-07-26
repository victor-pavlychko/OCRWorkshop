//
//  ErrorCallStackSymbols.swift
//  GenericError
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

public struct ErrorCallStackSymbols {
#if DEBUG || targetEnvironment(simulator)
    public static var isCallStackReportingEnabled = true
#else
    public static var isCallStackReportingEnabled = false
#endif

    public let callStackSymbols: [String]

    public init() {
        if type(of: self).isCallStackReportingEnabled {
            self.callStackSymbols = Thread.callStackSymbols
        } else {
            self.callStackSymbols = []
        }
    }
}

extension ErrorCallStackSymbols: CustomStringConvertible {
    public var description: String {
        return callStackSymbols.joined(separator: "\n")
    }
}
