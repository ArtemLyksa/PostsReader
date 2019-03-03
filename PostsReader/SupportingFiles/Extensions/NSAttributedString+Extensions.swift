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
     func underlined() -> NSMutableAttributedString {
        
        self.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: self.range)
        return self
    }
    
    @discardableResult
     func strikedThrough() -> NSMutableAttributedString {
        
        self.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: self.range)
        return self
    }
    
    @discardableResult
     func set(color: UIColor) -> NSMutableAttributedString {
        
        self.addAttributes([NSAttributedString.Key.foregroundColor: color], range: self.range)
        return self
    }
    
    @discardableResult
     func centered() -> NSMutableAttributedString {
        
        return self.with(alignment: .center)
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
    
     func style(_ text: String, color: UIColor, font: UIFont) {
        
        let pattern = text
        let regex = try! NSRegularExpression.init(pattern: pattern,
                                                  options: NSRegularExpression.Options(rawValue: 0))
        let matches = regex.matches(in: self.string,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange.init(location: 0, length: self.string.count))
        
        for result in matches {
            self.addAttribute(NSAttributedString.Key.font, value: font, range: result.range(at: 0))
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: result.range(at: 0))
        }
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
    
     func skipLine() {
        self.append(NSAttributedString(string: "\n\n"))
    }
    
    var range: NSRange {
        return NSRange(location: 0, length: self.length)
    }
    
    var mutable: NSMutableAttributedString {
        return NSMutableAttributedString(attributedString: self)
    }
}
