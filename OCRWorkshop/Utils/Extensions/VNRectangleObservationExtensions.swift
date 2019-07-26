//
//  VNRectangleObservationExtensions.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Vision

extension VNRectangleObservation {
    var flippedBoundingBox: CGRect {
        return CGRect(
            x: boundingBox.minX,
            y: 1 - boundingBox.minY - boundingBox.height,
            width: boundingBox.width,
            height: boundingBox.height
        )
    }
}
