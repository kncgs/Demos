//
//  UIView+Ex.swift
//  SwiftExample
//
//  Created by redtwowolf on 19/09/2017.
//  Copyright © 2017 pixle. All rights reserved.
//

import UIKit

protocol Shakeable {}

extension Shakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 4.0, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 4.0, y: center.y))
        layer.add(animation, forKey: "position")
    }
}

protocol Shadowable {}

extension Shadowable where Self: UIView {
    func shadow() {
        layer.cornerRadius = 8
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}


extension UIView {
    func border() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 4.0
    }
}
