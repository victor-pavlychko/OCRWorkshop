//
//  RootViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    @IBAction func showOriginal() {
        navigationController?.pushViewController(OriginalViewController(), animated: true)
    }

    @IBAction func showGrayscale() {
        navigationController?.pushViewController(GrayscaleViewController(), animated: true)
    }

    @IBAction func showLocalContrast() {
        navigationController?.pushViewController(LocalContrastViewController(), animated: true)
    }

    @IBAction func showTextBoxes() {
        navigationController?.pushViewController(TextBoxesViewController(), animated: true)
    }

    @IBAction func showInterestingText() {
        navigationController?.pushViewController(InterestingTextViewController(), animated: true)
    }

    @IBAction func showTextRecognition() {
        navigationController?.pushViewController(TextRecognitionViewController(), animated: true)
    }
}
