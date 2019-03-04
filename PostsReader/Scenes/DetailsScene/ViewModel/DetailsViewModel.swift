//
//  DetailsViewModel.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RxSwift


class DetailsViewModel: BaseViewModel {
    
    var data = GenericTableViewData(title: "Details".localized)
    
    private let postModel: PostModel!
    private var dataBaseService = DataBaseService(dataBase: RealmService())

    init(postModel: PostModel) {
        self.postModel = postModel
        super.init()
        fetchLocalData()
        data.setRightButton(GenericBarButton(title: "Reload".localized) { [weak self] in
            self?.getDetails()
        })
    }
    
    func getDetails() {
        isLoadingSubject.onNext(true)
        
        Observable.zip(
            NetworkService.shared.getUser(userId: postModel.userId),
            NetworkService.shared.getComments(postId: postModel.id)
            )
            .subscribe(onNext: { [weak self] result in
                
                var models: [Describable] = result.0
                models.append(contentsOf: result.1)
                
                self?.prepareForDisplay(models)
                self?.isLoadingSubject.onNext(false)
                },onError: { [weak self] error in
                    self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchLocalData() {
        // Fetch saved posts from local DB and show them
        // TODO: Implement fetching user + comments
    }
    
    private func prepareForDisplay(_ models: [Describable]) {
        let sectionItems = models.map({ model -> GenericSectionItem in
            return TextCellModel(identity: model.attributedDescription.string, model: model).sectionItem
        })
        self.data.set(sections: [GenericSectionModel(items: sectionItems, identity: "test")])
    }
}
