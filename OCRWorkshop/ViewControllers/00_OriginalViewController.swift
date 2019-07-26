//
//  OriginalViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/21/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

class OriginalViewController: BaseViewController {
    override func showContent(for image: UIImage) throws {
        imageView.image = image
    }
}
