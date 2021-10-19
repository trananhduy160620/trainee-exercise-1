//
//  UIImageExtension.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func createBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(visualEffectView)
    }
}
