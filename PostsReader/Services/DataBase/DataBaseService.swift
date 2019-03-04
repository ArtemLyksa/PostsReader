//
//  DataBaseService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

protocol DataBaseProtocol {
    
    func savePosts(_ posts: [PostModel])
    func getPosts() -> [PostModel]
    func saveUser()
    func getUser()
    func saveComments()
    func getComments()
    
}

struct DataBaseService {
    
    private let dataBase: DataBaseProtocol
    
    init(dataBase: DataBaseProtocol) {
        self.dataBase = dataBase
    }
    
    func savePosts(_ posts: [PostModel]) {
        dataBase.savePosts(posts)
    }
    
    func getPosts() -> [PostModel] {
        return dataBase.getPosts()
    }
    
}
