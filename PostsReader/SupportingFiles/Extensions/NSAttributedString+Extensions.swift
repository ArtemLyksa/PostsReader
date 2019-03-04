//
//  NSAttributedString+Extensions.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

 extension NSMutableAttributedString {
    
    @discardableResult
     func addLineSpacing(spacing: Int) -> NSMutableAttributedString {
        
        let paragraphStyle = self.findOrCreateAttribute(name: NSAttributedString.Key.paragraphStyle, type: NSMutableParagraphStyle.self)
        paragraphStyle.lineSpacing = CGFloat(spacing)
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: self.range)
        return self
    }
    
    @discardableResult
     func with(alignment: NSTextAlignment) -> NSMutableAttributedString {
        let paragraphStyle = self.findOrCreateAttribute(name: NSAttributedString.Key.paragraphStyle, type: NSMutableParagraphStyle.self)
        paragraphStyle.alignment = alignment
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: self.range)
        return self
    }
    
    @discardableResult
     func with(font: UIFont) -> NSMutableAttributedString {
        
        self.addAttribute(NSAttributedString.Key.font, value: font, range: self.range)
        return self
    }
    
    private func findOrCreateAttribute<T: NSObject>(name: NSAttributedString.Key, type: T.Type) -> T {
        
        guard self.length > 0 else {
            return T()
        }
        
        var range = self.range
        if let attribute = self.attribute(name, at: 0, effectiveRange: &range) as? T {
            return attribute
        } else {
            return T()
        }
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: self.length)
    }
    
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}
