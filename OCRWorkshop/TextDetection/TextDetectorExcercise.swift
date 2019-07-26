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
        #warning("Replace with your code")
        let hpBar = 0
        let whiteLineAfterHpBar = 0

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
