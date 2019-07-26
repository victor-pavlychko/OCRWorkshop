//
//  BitmapRowAnalyzerResult.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/23/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import Foundation

struct BitmapRowAnalyzerResult {
    var lines: [Line] = []

    struct Line {
        var row: Int
        var kind: Kind

        enum Kind {
            case white
            case hpBar
        }
    }
}
