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
        NetworkService.shared.getPosts()
            .subscribe(onNext: { [weak self] posts in
                
                let sectionItems = posts.map({ post -> GenericSectionItem in
                    let cellModel = PostCellModel(identity: post.title, postModel: post)
                    return GenericSectionItem(cellModel: cellModel)
                })
                
                self?.sections.value = [GenericSectionModel(items: sectionItems, identity: "test")]
                
            },onError: { error in
                //TODO: Handle error
                print("Got an error")
            })
            .disposed(by: disposeBag)
    }
}
