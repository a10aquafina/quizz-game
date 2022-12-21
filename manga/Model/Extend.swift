//
//  Extend.swift
//  manga
//
//  Created by Apple on 30/09/2021.
//

import Foundation

import UIKit

extension UICollectionView {
    public func shaking()  {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y ))
        self.layer.add(animation,forKey: "position")
    }
}
