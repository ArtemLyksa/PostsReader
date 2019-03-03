//
//  TextCellModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class TextCellModel: GTVManagedCellModelProtocol {
    
    var identity: String
    private var model: Describable
    
    init(identity: String, model: Describable) {
        self.identity = identity
        self.model = model
    }
    
    func configureCell(in tableView: UITableView, for index: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ofType: TextTableViewCell.self)
        cell.configure(with: model.attributedDescription)
        
        return cell
    }
    
}
