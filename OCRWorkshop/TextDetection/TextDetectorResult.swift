//
//  TextDetectorResult.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/26/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Vision

struct TextDetectorResult {
    var hp: TextBlock

    struct TextBlock {
        var boundingBox: CGRect
        var characterBoxes: [CGRect]

        init(_ textObservation: VNTextObservation, regionOfInterest: CGRect) throws {
            self.boundingBox = textObservation
                .flippedBoundingBox
                .denormalized(for: regionOfInterest.size)
                .offsetBy(dx: regionOfInterest.minX, dy: regionOfInterest.minY)

            self.characterBoxes = try textObservation
                .characterBoxes
                .unwrapped()
                .map { $0
                    .flippedBoundingBox
                    .denormalized(for: regionOfInterest.size)
                    .offsetBy(dx: regionOfInterest.minX, dy: regionOfInterest.minY)
                }
        }
    }
}
