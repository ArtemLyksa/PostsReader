//
//  PostModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

struct PostModel: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
