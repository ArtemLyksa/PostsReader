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
    
    var data = GenericTableViewData(title: "Posts".localized)
    
    func getPosts() {
        isLoadingSubject.onNext(true)
        
        NetworkService.shared.getPosts()
            .subscribe(onNext: { [weak self] posts in
                
                let sectionItems = posts.map({ post -> GenericSectionItem in
                    return PostCellModel(identity: post.title, postModel: post).sectionItem
                })
                self?.data.set(sections: [GenericSectionModel(items: sectionItems, identity: "test")])
                self?.isLoadingSubject.onNext(false)
            },onError: { [weak self] error in
                self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
