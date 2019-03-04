//
//  PostModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct PostModel: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    static func primaryKey() -> String? {
        return "id"
    }
}

extension PostModel: Describable {
    
    var attributedDescription: NSAttributedString {
        
        let description = "Post #\(id)\n"
            .with(alignment: .center)
            .with(font: UIFont.boldSystemFont(ofSize: 18))
            .addLineSpacing(spacing: 6)
        description.append(title.with(font: UIFont.systemFont(ofSize: 16)))
        
        return description
    }
}
