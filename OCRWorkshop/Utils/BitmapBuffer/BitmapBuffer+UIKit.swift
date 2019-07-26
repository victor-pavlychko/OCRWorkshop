//
//  BitmapBuffer+UIKit.swift
//  BitmapBuffer
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

extension BitmapBuffer {
    public convenience init(image: UIImage) throws {
        try self.init(image: image.cgImage.unwrapped())
    }
}
