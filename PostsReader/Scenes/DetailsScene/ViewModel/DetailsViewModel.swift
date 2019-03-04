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
    private lazy var dataBaseService = DataBaseService(dataBase: RealmService())

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
        
        Observable.zip(NetworkService.shared.getUser(userId: postModel.userId),
                       NetworkService.shared.getComments(postId: postModel.id))
            .subscribe(onNext: { [weak self] result in
                
                self?.dataBaseService.save(result.0) //User
                self?.dataBaseService.save(result.1) //Comments
                
                var models: [Describable] = result.0 //Create array with users
                models.append(contentsOf: result.1) //Append comments
                
                self?.prepareForDisplay(models)
                self?.isLoadingSubject.onNext(false)
                
                },onError: { [weak self] error in
                    self?.errorSubject.onNext(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchLocalData() {
        // Fetch saved users and comments from local DB and show them
        let user = dataBaseService.getUser(with: postModel.userId) as [Describable]
        let comments = dataBaseService.getComments(with: postModel.id) as [Describable]
                
        prepareForDisplay(user + comments)
    }
    
    private func prepareForDisplay(_ models: [Describable]) {
        let sectionItems = models.map({ model -> GenericSectionItem in
            return TextCellModel(identity: model.attributedDescription.string, model: model).sectionItem
        })
        data.set(sections: [GenericSectionModel(items: sectionItems, identity: "Details")])
    }
}
