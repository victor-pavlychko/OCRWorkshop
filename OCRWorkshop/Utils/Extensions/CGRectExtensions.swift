//
//  CGRectExtensions.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Vision

extension CGRect {
    func denormalized(for size: CGSize) -> CGRect {
        return VNImageRectForNormalizedRect(self, Int(size.width), Int(size.height))
    }
}
