//
//  PostRealm.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PostRealm: Object {
    
    dynamic var userId: Int = 0
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with post: PostModel) {
        self.init()
        self.userId = post.userId
        self.id = post.id
        self.title = post.title
        self.body = post.body
    }
    
    func decode() -> PostModel {
        return PostModel(userId: userId, id: id, title: title, body: body)
    }
}

extension Array where Element == PostRealm {
    
    func decodeItems() -> [PostModel] {
        return self.map({ $0.decode() })
    }
}

extension Array where Element == PostModel {
    
    func encodeItems() -> [PostRealm] {
        return self.map({ PostRealm(with: $0) })
    }
}
