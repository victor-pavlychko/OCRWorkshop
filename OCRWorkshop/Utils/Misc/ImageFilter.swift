//
//  BaseFilter.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/23/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import CoreImage

protocol ImageFilter {
    func apply(to image: CIImage) throws -> CIImage
}

extension CIImage {
    func applyingFilter(_ filter: ImageFilter) throws -> CIImage {
        return try filter.apply(to: self)
    }
}

class KernelFilterBase<KernelType> where KernelType: CIKernel {
    let kernel: KernelType

    init(name: String, bundle: Bundle) throws {
        self.kernel = try bundle
            .url(forResource: name, withExtension: "cikernel")
            .map { try String(contentsOf: $0) }
            .flatMap { KernelType(source: $0) }
            .unwrapped(or: GenericError("Failed to load kernel \(name) from \(bundle)"))
    }

    convenience init() throws {
        try self.init(
            name: String(describing: type(of: self)).components(separatedBy: ".").last.unwrapped(),
            bundle: Bundle(for: type(of: self))
        )
    }
}

class GenericKernelFilter: KernelFilterBase<CIKernel>, ImageFilter {
    func apply(to image: CIImage) throws -> CIImage {
        return try kernel
            .apply(extent: image.extent, roiCallback: regionOfInterest, arguments: [image])
            .unwrapped(or: GenericError("Failed to apply kernel \(kernel)"))
    }

    func regionOfInterest(for index: Int32, rect: CGRect) -> CGRect {
        return rect
    }
}

class ColorKernelFilter: KernelFilterBase<CIColorKernel>, ImageFilter {
    func apply(to image: CIImage) throws -> CIImage {
        return try kernel
            .apply(extent: image.extent, arguments: [image])
            .unwrapped(or: GenericError("Failed to apply kernel \(kernel)"))
    }
}
