//
//  GrayscaleViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit
import CoreImage

class GrayscaleViewController: BaseViewController {
    override func showContent(for image: UIImage) throws {
        let grayscaleImage = try CIImage(image: image)
            .unwrapped()
            .applyingFilter(GrayscaleFilter())

        imageView.image = UIImage(ciImage: grayscaleImage)
    }
}
