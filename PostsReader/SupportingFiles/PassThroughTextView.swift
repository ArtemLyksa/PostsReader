//
//  PassThroughTextView.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

/// This class allows clicking links from attributed text, but passes any other touches to it's superview
// https://stackoverflow.com/questions/36198299/uitextview-disable-selection-allow-links
class PassThroughTextView: UITextView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        guard let pos = closestPosition(to: point) else { return false }
        
        guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: UITextDirection(rawValue: UITextLayoutDirection.left.rawValue)) else { return false }
        
        let startIndex = offset(from: beginningOfDocument, to: range.start)
        let length = offset(from: range.start, to: range.end)
        
        if attributedText.containsAttachments(in: NSRange(location: startIndex, length: length)) {
            return true
        }
        return attributedText.attribute(NSAttributedString.Key.link, at: startIndex, effectiveRange: nil) != nil
    }
}
