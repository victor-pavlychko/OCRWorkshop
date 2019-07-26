//
//  BitmapRowAnalyzer.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/23/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

class BitmapRowAnalyzer {
    private let bitmapBuffer: BitmapBuffer<GrayscalePixel>

    init(bitmapBuffer: BitmapBuffer<GrayscalePixel>) {
        self.bitmapBuffer = bitmapBuffer
    }

    func analyze() throws -> BitmapRowAnalyzerResult {
        return try bitmapBuffer.withData { accessor in
            return try analyzeBitmap(accessor)
        }
    }

    private func analyzeBitmap(_ accessor: BitmapBuffer<GrayscalePixel>.RawDataAccessor) throws -> BitmapRowAnalyzerResult {
        var result = BitmapRowAnalyzerResult()

        var lastRowKind: BitmapRowAnalyzerResult.Line.Kind?
        for row in 0 ..< accessor.height {
            let info = analyzeRow(accessor, row: row)
            let kind = classifyRow(info)

            if kind != lastRowKind, let kind = kind {
                result.lines.append(BitmapRowAnalyzerResult.Line(row: row, kind: kind))
            }

            lastRowKind = kind
        }

        return result
    }

    private func classifyRow(_ info: BitmapRowAnalyzerRowInfo) -> BitmapRowAnalyzerResult.Line.Kind? {
        if isWhitePanel(info) {
            return .some(.white)
        }
        if isHpBar(info) {
            return .some(.hpBar)
        }

        return .none
    }

    private func analyzeRow(_ accessor: BitmapBuffer<GrayscalePixel>.RawDataAccessor, row: Int) -> BitmapRowAnalyzerRowInfo {
        var result = BitmapRowAnalyzerRowInfo()

        for col in 0 ..< accessor.width {
            let value = accessor[row, col].pointee.value
            if value < 64 {
                result.blackLine.append(col)
                result.blackCount += 1
            } else if value > 192 {
                result.whiteLine.append(col)
                result.whiteCount += 1
            }
        }

        return result
    }

    private func isHpBar(_ info: BitmapRowAnalyzerRowInfo) -> Bool {
        return
            info.blackLine.bestLine.length < bitmapBuffer.width * 2 / 3 &&
            info.blackLine.bestLine.length > bitmapBuffer.width / 3
    }

    private func isWhitePanel(_ info: BitmapRowAnalyzerRowInfo) -> Bool {
        return
            info.whiteLine.bestLine.length > bitmapBuffer.width / 2
    }
}
