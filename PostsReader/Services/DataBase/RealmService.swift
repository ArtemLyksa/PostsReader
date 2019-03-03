//
//  RealmService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift

struct RealmService: DataBaseProtocol {
    
    static let currentSchemaVersion: UInt64 = 0
    
    init() {
        let config = Realm.Configuration(schemaVersion: RealmService.currentSchemaVersion,
                                         migrationBlock: { migration, oldSchemaVersion in
            
            if oldSchemaVersion < RealmService.currentSchemaVersion {
                migration.deleteData(forType: "PostRealm")
                migration.deleteData(forType: "UserRealm")
                migration.deleteData(forType: "CommentRealm")
            }
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    func savePosts(_ posts: [PostModel]) {
        let realm = Realm.safeInit()
        realm?.safeWrite {
            realm?.add(posts.encodeItems())
        }
    }
    
    func getPosts() -> [PostModel] {
        let realm = Realm.safeInit()
        return realm?.objects(PostRealm.self).toArray().decodeItems() ?? []
    }
    
    func saveUser() {
        
    }
    
    func getUser() {
        
    }
    
    func saveComments() {
        
    }
    
    func getComments() {
        
    }
    
}
