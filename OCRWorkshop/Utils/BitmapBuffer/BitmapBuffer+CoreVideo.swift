//
//  BitmapBuffer+CoreVideo.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import CoreVideo

extension BitmapBuffer.RawDataAccessor {
    public func withPixelBuffer<R>(execute block: (CVPixelBuffer) throws -> R) throws -> R {
        let attributes: [CFString: Any] = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true,
            kCVPixelBufferMetalCompatibilityKey: true,
        ]

        var pixelBuffer: CVPixelBuffer?
        let statusCode = CVPixelBufferCreateWithBytes(
            kCFAllocatorDefault,
            width,
            height,
            PixelFormat.coreVideoPixelFormat,
            baseAddress,
            bytesPerRow,
            nil,
            nil,
            attributes as CFDictionary,
            &pixelBuffer
        )

        guard statusCode == kCVReturnSuccess else {
            throw GenericError("CoreVideo error code \(statusCode)")
        }

        return try block(pixelBuffer.unwrapped())
    }
}

extension BitmapBuffer {
    public func withPixelBuffer<R>(execute block: (CVPixelBuffer) throws -> R) throws -> R {
        return try withData { accessor in
            return try accessor.withPixelBuffer(execute: block)
        }
    }
}
