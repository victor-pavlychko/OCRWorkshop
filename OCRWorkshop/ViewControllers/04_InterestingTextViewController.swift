//
//  InterestingTextViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit
import CoreImage
import Vision

class InterestingTextViewController: BaseViewController {
    override func showContent(for image: UIImage) throws {
        let grayscaleImage = try CIImage(image: image)
            .unwrapped()
            .applyingFilter(GrayscaleFilter())
            .applyingFilter(LocalContrastFilter())

        let grayscaleBuffer = try BitmapBuffer<GrayscalePixel>(image: grayscaleImage)

        let bitmapRowInfo = try BitmapRowAnalyzer(bitmapBuffer: grayscaleBuffer).analyze()

        let textDetectorInfo = try TextDetector(bitmapBuffer: grayscaleBuffer, bitmapRowInfo: bitmapRowInfo).detect()

        let colorBuffer = try BitmapBuffer<RGBAPixel>(image: image)
        try colorBuffer.withDebugDrawContext { accessor in
            accessor.debugDrawRect(textDetectorInfo.hp.boundingBox, color: .blue)
            for characterBox in textDetectorInfo.hp.characterBoxes {
                accessor.debugDrawRect(characterBox, color: .red)
            }
        }

        imageView.image = try! UIImage(cgImage: colorBuffer.makeImage())
    }
}
