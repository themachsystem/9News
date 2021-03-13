//
//  UIView+AddShadow.swift
//  News
//
//  Created by Alvis Mach on 12/3/21.
//

import UIKit

extension UIView {
    /**
     * Adds a light shadow around the view
     */
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 3
        self.layer.shouldRasterize = true
    }
}
