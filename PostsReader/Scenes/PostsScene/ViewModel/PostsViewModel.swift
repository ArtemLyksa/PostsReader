//
//  PostsViewModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/1/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxSwift

class PostsViewModel: BaseViewModel {
    
    var sections = Variable([GenericSectionModel]())
    
    func getPosts() {
        NetworkService.shared.getPosts({ [weak self] result in
            switch result {
            case .success(let posts):
                let sectionItems = posts.map({ post -> GenericSectionItem in
                    let cellModel = PostCellModel(identity: post.title, postModel: post)
                    return GenericSectionItem(cellModel: cellModel)
                })
                self?.sections.value = [GenericSectionModel(items: sectionItems, identity: "test")]
            case .failure(let error):
                print(error)
            }
        })
    }
}
