//
//  UIView+Extension.swift
//  TerraAppNew
//
//  Created by Тимур Ахметов on 27.07.2022.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius: CGFloat, opacity: Float) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = opacity
        layer.shadowColor = UIColor.specialGreen.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 3)
    }
    
    func addShadowOnView() {
        layer.shadowColor = UIColor.specialGreen.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1.0
    }
}
