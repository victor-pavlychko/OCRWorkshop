//
//  TextRecognizer.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/26/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

class TextRecognizer {
    private let bitmapBuffer: BitmapBuffer<GrayscalePixel>
    private let textDetectorInfo: TextDetectorResult

    private let characterSize: CGFloat = 32
    private let threshold: Double = 0.8
    private let hpClassifier = HpClassifier()

    init(bitmapBuffer: BitmapBuffer<GrayscalePixel>, textDetectorInfo: TextDetectorResult) throws {
        self.bitmapBuffer = bitmapBuffer
        self.textDetectorInfo = textDetectorInfo
    }

    func recognize() throws -> String {
        return try bitmapBuffer.withData { accessor in
            return try analyzeTextBlock(textDetectorInfo.hp)
        }
    }

    private func analyzeTextBlock(_ textBlock: TextDetectorResult.TextBlock) throws -> String {
        #warning("Replace with your code")
        throw GenericError("Not implemented")
    }

    private func analyzeSymbol(boundingBox: CGRect, characterBox: CGRect) throws -> String? {
        let symbol = try extractSymbol(boundingBox: boundingBox, characterBox: characterBox)

        return try symbol.withPixelBuffer { pixelBuffer in
            return try classify(pixelBuffer)
        }
    }

    private func classify(_ pixelBuffer: CVPixelBuffer) throws -> String? {
        #warning("Replace with your code")
        let classLabel = ""
        let probability = 0.0
        guard probability > threshold else {
            return nil
        }

        switch classLabel {
        case "_slash_":
            return "/"
        case let classLabel:
            return classLabel
        }
    }

    private func extractSymbol(boundingBox: CGRect, characterBox: CGRect) throws -> BitmapBuffer<GrayscalePixel> {
        let lineHeight = boundingBox.height

        var alignedBox = CGRect(
            x: (lineHeight - min(characterBox.width, lineHeight)) / 2,
            y: lineHeight - (characterBox.maxY - boundingBox.minY), // CGContext is flipped vertically
            width: min(characterBox.width, lineHeight),
            height: characterBox.height
        )

        if characterSize != lineHeight {
            alignedBox.origin.x = alignedBox.origin.x * characterSize / lineHeight
            alignedBox.origin.y = alignedBox.origin.y * characterSize / lineHeight
            alignedBox.size.width = alignedBox.size.width * characterSize / lineHeight
            alignedBox.size.height = alignedBox.size.height * characterSize / lineHeight
        }

        let cropped = try bitmapBuffer.withRect(characterBox) { try $0.makeImage() }
        let symbol = try BitmapBuffer<GrayscalePixel>(width: Int(characterSize), height: Int(characterSize))
        try symbol.withContext { accessor in
            accessor.context.setFillColor(UIColor.white.cgColor)
            accessor.context.fill(accessor.rect)
            accessor.context.draw(cropped, in: alignedBox)
        }

        return symbol
    }
}
