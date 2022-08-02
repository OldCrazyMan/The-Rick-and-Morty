//
//  UILabel + Extensions.swift
//  TerraAppNew
//
//  Created by Тимур Ахметов on 27.07.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont?, color: UIColor, line: Int) {
        self.init()
        
        self.numberOfLines = line
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.8
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setHighlighted(_ text: String, with search: String) {
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSString(string: text).range(of: search, options: .caseInsensitive)
        let highlightedAttributes = [NSAttributedString.Key.backgroundColor: UIColor.lightGray]
        
        attributedText.addAttributes(highlightedAttributes, range: range)
        self.attributedText = attributedText
    }
}


