//
//  BaseViewController.swift
//  PokeScanPreprocessing
//
//  Created by Victor Pavlychko on 7/25/19.
//  Copyright © 2019 Victor Pavlychko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleNavigationBar)))

        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(imageView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let activityIndicator = UIActivityIndicatorView(style: .gray)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()

        DispatchQueue.main.async {
            defer {
                self.navigationItem.rightBarButtonItem = nil
            }
            do {
                let image = try UIImage(named: "test01").unwrapped(or: GenericError("Failed to load image"))
                try self.showContent(for: image)
            } catch {
                let alertViewController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }

    @objc func toggleNavigationBar() {
        navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
        setNeedsStatusBarAppearanceUpdate()
    }

    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden ?? false
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    func showContent(for image: UIImage) throws {
        fatalError("Function \(#function) not implemented in \(type(of: self))")
    }
}
