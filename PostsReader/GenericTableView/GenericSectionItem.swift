//
//  GenericSectionItem.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct GenericSectionItem: IdentifiableType {
    
    var identity: String {
        return cellModel.identity
    }
    var cellModel: GTVManagedCellModelProtocol
   
}

extension GenericSectionItem: Equatable {
    
    static func == (lhs: GenericSectionItem, rhs: GenericSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
    
}

