//
//  CommentModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct CommentModel: Decodable {
    var postId: String
    var id: Int
    var name: String
    var email: String
    var body: String
}

extension CommentModel: Describable {
    
    var attributedDescription: NSAttributedString {
        
        let description = "Comment #\(id)"
            .with(alignment: .center)
            .with(font: UIFont.boldSystemFont(ofSize: 18))
            .addLineSpacing(spacing: 6)
        
        description.append(create(propertyName: "Name", value: name))
        description.append(create(propertyName: "Email", value: email))
        description.append(body.with(font: UIFont.systemFont(ofSize: 16)))
        
        return description
    }
    
    private func create(propertyName: String, value: String) -> NSAttributedString {
        let string = "\(propertyName.localized): ".with(font: UIFont.boldSystemFont(ofSize: 16)).mutable
        string.append(value.with(font: UIFont.systemFont(ofSize: 16)))
        return string
    }
}

