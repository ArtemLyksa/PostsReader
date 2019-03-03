//
//  DataBaseService.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

protocol DataBaseProtocol {
    func save()
    func delete()
}

struct DataBaseService {
    
    private let dataBase: DataBaseProtocol
    
    init(dataBase: DataBaseProtocol) {
        self.dataBase = dataBase
    }
    
}
