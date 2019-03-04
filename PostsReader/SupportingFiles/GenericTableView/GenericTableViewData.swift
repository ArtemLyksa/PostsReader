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
    
    var rightBarButton: Observable<GenericBarButton?> {
        return rightBarButtonRelay.asObservable()
    }
    
    private let sectionsRelay: BehaviorRelay<[GenericSectionModel]>
    private let rightBarButtonRelay: BehaviorRelay<GenericBarButton?> = BehaviorRelay(value: nil)
    
    init(title: String) {
        self.title = title
        self.sectionsRelay = BehaviorRelay(value: [])
    }
    
    func set(sections: [GenericSectionModel]) {
        sectionsRelay.accept(sections)
    }
    
    func setRightButton(_ genericBarButton: GenericBarButton) {
        rightBarButtonRelay.accept(genericBarButton)
    }
}

struct GenericBarButton {
    let title: String
    let action: () -> Void
}


extension GenericTableViewData {
    
    subscript(indexPath: IndexPath) -> GenericSectionItem? {
        get {
            return sectionsRelay.value[indexPath.section].items[indexPath.row]
        }
    }
    
}
