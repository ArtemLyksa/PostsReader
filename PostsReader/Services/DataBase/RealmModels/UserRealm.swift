//
//  UserRealm.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class UserRealm: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var username: String = ""
    dynamic var email: String = ""
    dynamic var phone: String = ""
    dynamic var website: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(with model: UserModel) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.username = model.username
        self.email = model.email
        self.phone = model.phone
        self.website = model.website
    }
}

extension UserModel: Persistable {
    
    init(managedObject: UserRealm) {
        self.init(id: managedObject.id,
                  name: managedObject.name,
                  username: managedObject.username,
                  email: managedObject.email,
                  phone: managedObject.phone,
                  website:managedObject.website)
    }
    
    func managedObject() -> UserRealm {
        return UserRealm(with: self)
    }
    
    enum Query: QueryType {
        case userId(Int)
        
        var predicate: NSPredicate? {
            switch self {
            case .userId(let id):
                return NSPredicate(format: "id == %i", id)
            }
        }
    }
}
