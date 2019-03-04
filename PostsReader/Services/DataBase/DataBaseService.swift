//
//  DataBaseService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

protocol DataBaseProtocol {
    
    func getPosts() -> [PostModel]
    
    func getUser(with id: Int) -> [UserModel]
    
    func getComments(with postId: Int) -> [CommentModel]
    
    func save<T: Persistable>(_ models: [T])
}

struct DataBaseService {
    
    private let dataBase: DataBaseProtocol
    
    init(dataBase: DataBaseProtocol) {
        self.dataBase = dataBase
    }
    
    // MARK: Posts
    
    func getPosts() -> [PostModel] {
        return dataBase.getPosts()
    }
    
    // MARK: Users
    
    func getUser(with id: Int) -> [UserModel] {
        return dataBase.getUser(with: id)
    }
    
    // MARK: Comments
    
    func getComments(with postId: Int) -> [CommentModel] {
        return dataBase.getComments(with: postId)
    }
    
    // MARK: Generic
    
    func save<T: Persistable>(_ models: [T]) {
        dataBase.save(models)
    }
    
}
