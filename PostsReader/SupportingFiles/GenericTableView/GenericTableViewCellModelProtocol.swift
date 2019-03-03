//
//  GenericTableViewCellModelProtocol.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxSwift

protocol GTVManagedCellModelProtocol: class {
    
    /// Unique identifier of cell instance in table view.
    var identity: String { get }
    
    /// Convert model into section item
    var sectionItem: GenericSectionItem { get }
    
    /// Configures content and returns cell.
    func configureCell(in tableView: UITableView, for index: IndexPath) -> UITableViewCell
    
}

extension GTVManagedCellModelProtocol {
    
    var sectionItem: GenericSectionItem {
        return GenericSectionItem(cellModel: self)
    }
    
}
