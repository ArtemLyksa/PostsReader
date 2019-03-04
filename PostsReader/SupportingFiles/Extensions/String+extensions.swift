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
