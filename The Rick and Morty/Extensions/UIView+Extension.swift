//
//  UIView+Extension.swift
//  TerraAppNew
//
//  Created by Тимур Ахметов on 27.07.2022.
//

import UIKit

extension UIView {
    func applyShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor.specialGreen.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}
