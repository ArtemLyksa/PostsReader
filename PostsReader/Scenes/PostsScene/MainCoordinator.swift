//
//  MainCoordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift

class MainCoordinator: Coordinator {
    
    let window: UIWindow?
    var navigationController: UINavigationController
    
    lazy var childCoordinators: [Coordinator] = []
    lazy var disposeBag = DisposeBag()
    
    var pop: Observable<Void> {
        return popSubject.asObservable()
    }
    
    private lazy var popSubject = PublishSubject<Void>()
    
    init(window: UIWindow?, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let viewController = PostsViewController.instantiate()
        viewController.viewModel = PostsViewModel()
        
        viewController.viewModel?.selectedPost
            .subscribe(onNext: { [weak self] post in
                self?.postSelected(post: post)
            }).disposed(by: viewController.disposeBag)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator {
    
    func postSelected(post: PostModel) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, postModel: post)
        
        childCoordinators.append(detailsCoordinator)
        detailsCoordinator.start()
        
        detailsCoordinator.pop.subscribe(onNext: { [weak self] in
            self?.childCoordinators.removeLast()
        }).disposed(by: detailsCoordinator.disposeBag)
    }
}
