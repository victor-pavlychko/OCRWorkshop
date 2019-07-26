//
//  BitmapRowAnalyzeInfo.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/23/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

struct BitmapRowAnalyzerRowInfo {
    var whiteCount = 0
    var blackCount = 0
    var whiteLine = BestLine()
    var blackLine = BestLine()

    mutating func flush() {
        whiteLine.flushLastLine()
        blackLine.flushLastLine()
    }

    struct Line {
        var start: Int
        var end: Int

        init() {
            start = 0
            end = 0
        }

        init(_ col: Int) {
            start = col
            end = col + 1
        }

        var length: Int {
            return end - start
        }

        mutating func append(_ col: Int) -> Bool {
            if end == col {
                end = col + 1
                return true
            }

            if start == end {
                start = col
                end = col + 1
                return true
            }

            return false
        }
    }

    struct BestLine {
        var bestLine = Line()
        var lastLine = Line()

        mutating func append(_ col: Int) {
            if !lastLine.append(col) {
                flushLastLine()
                lastLine = Line(col)
            }
        }

        mutating func flushLastLine() {
            if lastLine.length > bestLine.length {
                bestLine = lastLine
            }
        }
    }
}
