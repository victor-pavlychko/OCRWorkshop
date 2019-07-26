//
//  BinaryIntegerExtensions.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

extension BinaryInteger {
    func roundedUp(to multiplier: Self) -> Self {
        return (self + multiplier - 1) / multiplier * multiplier
    }
}
