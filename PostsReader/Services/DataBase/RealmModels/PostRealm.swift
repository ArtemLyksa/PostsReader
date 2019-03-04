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
    
    convenience init(with model: PostModel) {
        self.init()
        self.userId = model.userId
        self.id = model.id
        self.title = model.title
        self.body = model.body
    }
    
}

extension PostModel: Persistable {
    
    init(managedObject: PostRealm) {
        self.init(userId: managedObject.userId,
                  id: managedObject.id,
                  title: managedObject.title,
                  body: managedObject.body)
    }
    
    func managedObject() -> PostRealm {
        return PostRealm(with: self)
    }
    
    struct Query: QueryType {
        var predicate: NSPredicate? {
            return nil
        }
    }
}
