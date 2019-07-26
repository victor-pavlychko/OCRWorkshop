//
//  BitmapBuffer.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import QuartzCore

public final class BitmapBuffer<PixelFormat: PixelFormatProtocol> {
    public let width: Int
    public let height: Int
    public let bytesPerRow: Int
    public let baseAddress: UnsafeMutableRawPointer
    public let freeWhenDone: Bool

    private init(width: Int, height: Int, bytesPerRow: Int, baseAddress: UnsafeMutableRawPointer, freeWhenDone: Bool) {
        assert(width >= 0)
        assert(height >= 0)

        self.width = width
        self.height = height
        self.bytesPerRow = bytesPerRow
        self.baseAddress = baseAddress
        self.freeWhenDone = freeWhenDone
    }

    public init(width: Int, height: Int) throws {
        assert(width >= 0)
        assert(height >= 0)

        self.width = width
        self.height = height
        self.bytesPerRow = (width * PixelFormat.bytesPerPixel).roundedUp(to: 4)
        self.baseAddress = UnsafeMutableRawPointer.allocate(byteCount: height * bytesPerRow, alignment: MemoryLayout<PixelFormat>.alignment)
        self.freeWhenDone = true
    }

    deinit {
        if freeWhenDone {
            baseAddress.deallocate()
        }
    }
}

extension BitmapBuffer {
    public convenience init(size: CGSize) throws {
        try self.init(width: Int(size.width), height: Int(size.height))
    }

    public var size: CGSize {
        return CGSize(width: width, height: height)
    }

    public var rect: CGRect {
        return CGRect(origin: .zero, size: size)
    }
}

extension BitmapBuffer {
    public func withRect<R>(_ rect: CGRect, execute block: (BitmapBuffer<PixelFormat>) throws -> R) throws -> R {
        let row = Int(rect.minY)
        let col = Int(rect.minX)
        let width = Int(rect.width)
        let height = Int(rect.height)

        assert(row >= 0)
        assert(col >= 0)
        assert(row + height <= self.height)
        assert(col + width <= self.width)

        guard row >= 0 && col >= 0 && row + height <= self.height && col + width <= self.width else {
            throw GenericError("Region out of bounds")
        }

        let regionBuffer = BitmapBuffer<PixelFormat>(
            width: width,
            height: height,
            bytesPerRow: bytesPerRow,
            baseAddress: baseAddress.advanced(by: row * bytesPerRow + col * MemoryLayout<PixelFormat>.stride),
            freeWhenDone: false
        )

#if DEBUG
        assert(regionBuffer.baseAddress >= baseAddress)
        let xx = regionBuffer.baseAddress + (regionBuffer.height - 1) * regionBuffer.bytesPerRow + regionBuffer.width * MemoryLayout<PixelFormat>.stride
        assert(xx <= baseAddress + self.height * bytesPerRow)
#endif

        return try block(regionBuffer)
    }
}
