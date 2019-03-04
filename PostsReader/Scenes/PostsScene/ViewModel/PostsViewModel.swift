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
    var selectedPost: Observable<PostModel> {
        return selectedPostSubject.asObservable()
    }
    
    private var dataBaseService = DataBaseService(dataBase: RealmService())
    private let selectedPostSubject = PublishSubject<PostModel>()
    
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
                self?.dataBaseService.save(posts)
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
            let sectionItem = TextCellModel(identity: post.title, model: post).sectionItem
            
            sectionItem.wasSelected
                .map({ _ in return post })
                .bind(to: selectedPostSubject)
                .disposed(by: disposeBag)
            
            
            return sectionItem
        })
        self.data.set(sections: [GenericSectionModel(items: sectionItems, identity: "test")])
    }
}
