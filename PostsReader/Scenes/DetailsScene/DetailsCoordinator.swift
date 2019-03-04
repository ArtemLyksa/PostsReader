//
//  DetailsCoordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift

class DetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    lazy var childCoordinators: [Coordinator] = []
    lazy var disposeBag = DisposeBag()
    
    var pop: Observable<Void> {
        return popSubject.asObservable()
    }
    
    private let popSubject = PublishSubject<Void>()
    
    private var postModel: PostModel
    
    init(navigationController: UINavigationController, postModel: PostModel) {
        self.navigationController = navigationController
        self.postModel = postModel
    }
    
    func start() {
        let viewController = DetailsViewController.instantiate()
        viewController.viewModel = DetailsViewModel(postModel: postModel)
        
        viewController.pop
            .bind(to: popSubject)
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
