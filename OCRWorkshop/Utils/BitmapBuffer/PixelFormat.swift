//
//  PixelFormat.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 12/19/18.
//  Copyright © 2018 Victor Pavlychko. All rights reserved.
//

import QuartzCore
import CoreVideo

public protocol PixelFormatProtocol: Equatable {
    static var bitmapInfo: UInt32 { get }
    static var bitsPerComponent: Int { get }
    static var bytesPerPixel: Int { get }
    static var colorSpace: CGColorSpace { get }
    static var coreVideoPixelFormat: OSType { get }
}

extension PixelFormatProtocol {
    @_transparent
    public static var bytesPerPixel: Int {
        return MemoryLayout<Self>.stride
    }
}

public struct RGBAPixel: PixelFormatProtocol {
    public var b: UInt8
    public var g: UInt8
    public var r: UInt8
    public var a: UInt8

    public init(_ r: UInt8, _ g: UInt8, _ b: UInt8, _ a: UInt8 = 255) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }

    public static let bitmapInfo = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue
    public static let bitsPerComponent = 8
    public static let colorSpace = CGColorSpaceCreateDeviceRGB()
    public static let coreVideoPixelFormat = kCVPixelFormatType_32BGRA
}

public struct GrayscalePixel: PixelFormatProtocol {
    public var value: UInt8

    public init(_ value: UInt8) {
        self.value = value
    }

    public static let bitmapInfo = CGImageAlphaInfo.none.rawValue
    public static let bitsPerComponent = 8
    public static let colorSpace = CGColorSpaceCreateDeviceGray()
    public static let coreVideoPixelFormat = kCVPixelFormatType_OneComponent8
}
