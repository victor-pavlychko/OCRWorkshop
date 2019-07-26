//
//  TextBoxesViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit
import CoreImage
import Vision

class TextBoxesViewController: BaseViewController {
    override func showContent(for image: UIImage) throws {
        let grayscaleImage = try CIImage(image: image)
            .unwrapped()
            .applyingFilter(GrayscaleFilter())
            .applyingFilter(LocalContrastFilter())

        let grayscaleBuffer = try BitmapBuffer<RGBAPixel>(image: grayscaleImage)

        let textBlocks = try VisionTextDetector.detectTextRectangles(in: grayscaleBuffer)

        let colorBuffer = try BitmapBuffer<RGBAPixel>(image: image)
        try colorBuffer.withDebugDrawContext { accessor in
            for block in textBlocks {
                accessor.debugDrawRect(block.flippedBoundingBox.denormalized(for: accessor.size), color: .blue)
                if let characterBoxes = block.characterBoxes {
                    for character in characterBoxes {
                        accessor.debugDrawRect(character.flippedBoundingBox.denormalized(for: accessor.size), color: .red)
                    }
                }
            }
        }

        imageView.image = try! UIImage(cgImage: colorBuffer.makeImage())
    }
}
