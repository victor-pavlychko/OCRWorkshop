//
//  BitmapBuffer+CoreGraphics.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import QuartzCore

extension BitmapBuffer {
    public convenience init(image: CGImage) throws {
        try self.init(width: image.width, height: image.height)
        try withContext { accessor in
            accessor.context.draw(image, in: accessor.rect)
        }
    }
}

public struct BitmapBufferContextAccessor {
    public let width: Int
    public let height: Int
    public let context: CGContext

    public var size: CGSize {
        return CGSize(width: width, height: height)
    }

    public var rect: CGRect {
        return CGRect(origin: .zero, size: size)
    }
}

extension BitmapBuffer.RawDataAccessor {
    public func withContext<R>(execute block: (BitmapBufferContextAccessor) throws -> R) throws -> R {
        let context = CGContext(
            data: baseAddress,
            width: width,
            height: height,
            bitsPerComponent: PixelFormat.bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: PixelFormat.colorSpace,
            bitmapInfo: PixelFormat.bitmapInfo,
            releaseCallback: nil,
            releaseInfo: nil
        )

        let accessor = try BitmapBufferContextAccessor(
            width: width,
            height: height,
            context: context.unwrapped(or: GenericError("Failed to create CGContext"))
        )

        accessor.context.interpolationQuality = .high

        return try block(accessor)
    }
}

extension BitmapBuffer {
    public func withContext<R>(execute block: (BitmapBufferContextAccessor) throws -> R) throws -> R {
        return try withData { accessor in
            return try accessor.withContext(execute: block)
        }
    }
}

extension BitmapBuffer {
    public func makeImage() throws -> CGImage {
        return try withContext { accessor in
            return try accessor.context.makeImage().unwrapped()
        }
    }
}
