//
//  TextTableViewCell.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: PassThroughTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
    }
    
    func configure(with attributedText: NSAttributedString) {
        textView.attributedText = attributedText
    }
}
