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
    
    private var dataBaseService = DataBaseService(dataBase: RealmService())
    
    override init() {
        super.init()
        fetchLocalData()
        data.setRightButton(GenericBarButton(title: "Reload".localized) { [weak self] in
            self?.getPosts()
        })
    }
    
    func getPosts() {
        isLoadingSubject.onNext(true)
        
        NetworkService.shared.getPosts()
            .subscribe(onNext: { [weak self] posts in
                self?.dataBaseService.savePosts(posts)
                self?.prepareForDisplay(posts)
                self?.isLoadingSubject.onNext(false)
                },onError: { [weak self] error in
                    self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchLocalData() {
        // Fetch saved posts from local DB and show them
        prepareForDisplay(dataBaseService.getPosts())
    }
    
    private func prepareForDisplay(_ posts: [PostModel]) {
        let sectionItems = posts.map({ post -> GenericSectionItem in
            return PostCellModel(identity: post.title, postModel: post).sectionItem
        })
        self.data.set(sections: [GenericSectionModel(items: sectionItems, identity: "test")])
    }
}
