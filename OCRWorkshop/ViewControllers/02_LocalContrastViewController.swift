//
//  LocalContrastViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit
import CoreImage

class LocalContrastViewController: BaseViewController {
    override func showContent(for image: UIImage) throws {
        let grayscaleImage = try CIImage(image: image)
            .unwrapped()
            .applyingFilter(GrayscaleFilter())
            .applyingFilter(LocalContrastFilter())

        imageView.image = UIImage(ciImage: grayscaleImage)
    }
}
