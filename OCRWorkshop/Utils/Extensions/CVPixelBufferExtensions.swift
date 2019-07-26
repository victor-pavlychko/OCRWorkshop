//
//  CVPixelBufferExtensions.swift
//  PokeScanSwift
//
//  Created by Victor Pavlychko on 12/19/18.
//  Copyright © 2018 Victor Pavlychko. All rights reserved.
//

import CoreVideo

extension CVPixelBuffer {
    public var width: Int {
        return CVPixelBufferGetWidth(self)
    }

    public var height: Int {
        return CVPixelBufferGetHeight(self)
    }

    var bytesPerRow: Int {
        return CVPixelBufferGetBytesPerRow(self)
    }
}
