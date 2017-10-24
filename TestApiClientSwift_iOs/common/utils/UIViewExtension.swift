//
//  UIViewExtension.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 24.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
