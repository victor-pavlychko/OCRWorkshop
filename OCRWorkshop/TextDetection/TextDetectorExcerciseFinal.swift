//
//  TextDetector.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/26/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Vision

class TextDetector {
    private let bitmapBuffer: BitmapBuffer<GrayscalePixel>
    private let bitmapRowInfo: BitmapRowAnalyzerResult

    init(bitmapBuffer: BitmapBuffer<GrayscalePixel>, bitmapRowInfo: BitmapRowAnalyzerResult) {
        self.bitmapBuffer = bitmapBuffer
        self.bitmapRowInfo = bitmapRowInfo
    }

    func detect() throws -> TextDetectorResult {
        let hpBar = try bitmapRowInfo
            .lines
            .drop { $0.kind != .white }
            .first { $0.kind == .hpBar }
            .unwrapped(or: GenericError("HP bar not found"))
            .row

        let whiteLineAfterHpBar = try bitmapRowInfo
            .lines
            .drop { $0.kind != .white }
            .drop { $0.kind != .hpBar }
            .dropFirst()
            .filter {  $0.kind == .white }
            .dropFirst()
            .first
            .unwrapped(or: GenericError("Failed to find two white lines after HP bar"))
            .row

        let regionOfInterest = CGRect(
            x: 0,
            y: hpBar,
            width: bitmapBuffer.width,
            height: whiteLineAfterHpBar - hpBar
        )

        let textObservations = try bitmapBuffer.withRect(regionOfInterest) { regionBuffer in
            return try VisionTextDetector.detectTextRectangles(in: regionBuffer)
        }

        guard textObservations.count == 1 else {
            throw GenericError("Expected only one text observation")
        }

        return try TextDetectorResult(
            hp: TextDetectorResult.TextBlock(textObservations.first.unwrapped(), regionOfInterest: regionOfInterest)
        )
    }
}
