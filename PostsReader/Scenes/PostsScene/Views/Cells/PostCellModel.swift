//
//  PostCellModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class PostCellModel: GTVManagedCellModelProtocol {
    
    var identity: String
    private var postModel: PostModel
    
    init(identity: String, postModel: PostModel) {
        self.identity = identity
        self.postModel = postModel
    }
    
    func configureCell(in tableView: UITableView, for index: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ofType: PostTableViewCell.self)
        cell.configure(with: postModel)
        
        return cell
    }
    
}
