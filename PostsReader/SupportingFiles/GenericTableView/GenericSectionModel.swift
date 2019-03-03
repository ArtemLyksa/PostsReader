//
//  GenericSectionModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct GenericSectionModel: SectionModelType, AnimatableSectionModelType {
    
    typealias Item = GenericSectionItem
    
    var items: [GenericSectionItem]
    var identity: String
    
    /// items: objects that will be displayed in table view
    /// identity: unique string that will be using to calculate changes in section
    init(items: [GenericSectionItem], identity: String) {
        self.items = items
        self.identity = identity
    }
    
    init(original: GenericSectionModel, items: [GenericSectionItem]) {
        self = GenericSectionModel(items: items, identity: original.identity)
    }
    
    
}
