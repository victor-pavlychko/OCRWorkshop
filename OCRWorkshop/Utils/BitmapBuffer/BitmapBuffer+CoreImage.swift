//
//  BitmapBuffer+CoreImage.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import CoreImage

extension BitmapBuffer {
    public convenience init(image: CIImage, context: CIContext = CIContext()) throws {
        try self.init(width: Int(image.extent.width), height: Int(image.extent.height))
        try withPixelBuffer {
            context.render(image, to: $0)
        }
    }
}
