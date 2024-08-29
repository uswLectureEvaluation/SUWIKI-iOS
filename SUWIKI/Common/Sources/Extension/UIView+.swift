//
//  UIView+.swift
//  Common
//
//  Created by 한지석 on 8/28/24.
//

import UIKit

extension UIView {
  func roundBottomCorners(radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds,
                            byRoundingCorners: [.bottomLeft, .bottomRight],
                            cornerRadii: CGSize(width: radius, height: radius))
    let maskLayer = CAShapeLayer()
    maskLayer.path = path.cgPath
    maskLayer.fillColor = UIColor.blue.cgColor
    layer.mask = maskLayer
  }
}
