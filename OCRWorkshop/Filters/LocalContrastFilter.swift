//
//  LocalContrastFilter.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import CoreImage

class LocalContrastFilter: GenericKernelFilter {
    override func regionOfInterest(for index: Int32, rect: CGRect) -> CGRect {
        return rect.insetBy(dx: -20, dy: -20)
    }
}
