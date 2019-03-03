//
//  String+extensions.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

 extension String {
    
     func attributedNumber() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        if let url = URL(string: "tel:\(self.replacingOccurrences(of: " ", with: ""))") {
            attributedString.addAttribute(NSAttributedString.Key.link, value: url, range: NSMakeRange(0, self.count))
        }
        return attributedString
    }
    
     func attributedLink(address: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        if let url = URL(string: address) {
            attributedString.addAttribute(NSAttributedString.Key.link, value: url, range: NSMakeRange(0, self.count))
        }
        return attributedString
    }
    
     func strikedThrough() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, self.count))
        return attributedString
    }
    
     func set(color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, self.count))
        
        return attributedString
    }
    
     func with(font: UIFont) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self).with(font: font)
    }
    
     func with(alignment: NSTextAlignment) -> NSMutableAttributedString {
        
        let centerParagraphStyle = NSMutableParagraphStyle()
        centerParagraphStyle.alignment = alignment
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: centerParagraphStyle, range: NSMakeRange(0, self.count))
        
        return attributedString
    }
}
