//
//  CommentRealm.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class CommentRealm: Object {
    
    dynamic var postId = 0
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with model: CommentModel) {
        self.init()
        self.postId = model.postId
        self.id = model.id
        self.name = model.name
        self.email = model.email
        self.body = model.body
    }
}

extension CommentModel: Persistable {
    
    init(managedObject: CommentRealm) {
        self.init(postId: managedObject.postId,
                  id: managedObject.id,
                  name: managedObject.name,
                  email: managedObject.email,
                  body: managedObject.body)
    }
    
    func managedObject() -> CommentRealm {
        return CommentRealm(with: self)
    }
    
    enum Query: QueryType {
        case postId(Int)
        
        var predicate: NSPredicate? {
            switch self {
            case .postId(let postId):
                return NSPredicate(format: "postId == %i", postId)
            }
        }
    }
}
