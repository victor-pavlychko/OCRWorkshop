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
        var result: Result<[VNTextObservation], Error> = .failure(GenericError("Failed to fer results from VNDetectTextRectanglesRequest"))

        let semaphore = DispatchSemaphore(value: 0)
        let request = VNDetectTextRectanglesRequest { request, error in
            if let error = error {
                result = .failure(error)
            } else if let results = request.results?.compactMap({ $0 as? VNTextObservation }), !results.isEmpty {
                result = .success(results)
            } else {
                result = .failure(GenericError("No text found"))
            }
            semaphore.signal()
        }

        request.revision = VNDetectTextRectanglesRequestRevision1
        request.reportCharacterBoxes = true

        try bitmapBuffer.withPixelBuffer { pixelBuffer in
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
            semaphore.wait()
        }

        return try result.get()
    }
}
