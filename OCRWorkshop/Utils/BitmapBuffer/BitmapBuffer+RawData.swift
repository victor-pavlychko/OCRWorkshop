//
//  BitmapBuffer+RawData.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import QuartzCore

extension BitmapBuffer {
    public struct RawDataAccessor {
        public let width: Int
        public let height: Int
        public let bytesPerRow: Int
        public let bytesPerPixel = PixelFormat.bytesPerPixel
        public let baseAddress: UnsafeMutableRawPointer

        public subscript(_ row: Int) -> UnsafeMutableBufferPointer<PixelFormat> {
            @_transparent
            @_specialize(where PixelFormat == RGBAPixel)
            @_specialize(where PixelFormat == GrayscalePixel)
            get {
                assert(row >= 0 && row < height)

                return UnsafeMutableBufferPointer(
                    start: baseAddress
                        .advanced(by: row * bytesPerRow)
                        .assumingMemoryBound(to: PixelFormat.self),
                    count: width
                )
            }
        }

        public subscript(_ row: Int, _ col: Int) -> UnsafeMutablePointer<PixelFormat> {
            @_transparent
            @_specialize(where PixelFormat == RGBAPixel)
            @_specialize(where PixelFormat == GrayscalePixel)
            get {
                assert(row >= 0 && row < height)
                assert(col >= 0 && col < width)

                return baseAddress
                    .advanced(by: row * bytesPerRow + col * bytesPerPixel)
                    .assumingMemoryBound(to: PixelFormat.self)
            }
        }
    }
}

extension BitmapBuffer {
    public func withData<R>(execute block: (RawDataAccessor) throws -> R) throws -> R {
        let accessor = RawDataAccessor(
            width: width,
            height: height,
            bytesPerRow: bytesPerRow,
            baseAddress: baseAddress
        )

        return try block(accessor)
    }
}
