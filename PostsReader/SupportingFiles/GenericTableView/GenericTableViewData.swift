//
//  GenericTableViewData.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class GenericTableViewData {
    
    let title: String
    var sections: Observable<[GenericSectionModel]> {
        return sectionsRelay.asObservable()
    }
    
    private let sectionsRelay: BehaviorRelay<[GenericSectionModel]>
    
    init(title: String) {
        self.title = title
        self.sectionsRelay = BehaviorRelay(value: [])
    }
    
    func set(sections: [GenericSectionModel]) {
        sectionsRelay.accept(sections)
    }
}
