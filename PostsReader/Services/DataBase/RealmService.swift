//
//  RealmService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
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
    
    func getPosts() -> [PostModel] {
        return get(type: PostModel.self)
    }
    
    func getUser(with id: Int) -> [UserModel] {
        return get(type: UserModel.self, query: UserModel.Query.userId(id))
    }
    
    func getComments(with postId: Int) -> [CommentModel] {
        return get(type: CommentModel.self, query: CommentModel.Query.postId(postId))
    }
    
    func save<T: Persistable>(_ models: [T]) {
        guard let realm = Realm.safeInit() else { return }
        let container = Container(realm: realm)
        try! container.add(models, update: true)
    }
    
    private func get<T: Persistable>(type: T.Type, query: T.Query? = nil) -> [T] {
        guard let realm = Realm.safeInit() else { return [] }
        let container = Container(realm: realm)
        return container.values(type, matching: query)
    }
    
}
