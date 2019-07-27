//
//  VisionTextDetector.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/26/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Vision

enum VisionTextDetector {
    static func detectTextRectangles<PixelFormat>(in bitmapBuffer: BitmapBuffer<PixelFormat>) throws -> [VNTextObservation] where PixelFormat: PixelFormatProtocol {
        let request = VNDetectTextRectanglesRequest { request, error in
            if let result = request.results?.first as? VNTextObservation {
                print(result)
            }
        }

        request.revision = VNDetectTextRectanglesRequestRevision1
        request.reportCharacterBoxes = true

        try bitmapBuffer.withPixelBuffer { pixelBuffer in
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
        }

        #warning("Replace with your code")
        throw GenericError()
    }
}
