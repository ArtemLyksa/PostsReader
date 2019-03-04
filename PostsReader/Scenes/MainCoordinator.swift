//
//  MainCoordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    let window: UIWindow?
    var navigationController: UINavigationController
    
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
        let postsCoordinator = PostsCoordinator(navigationController: navigationController, postModel: post)
        postsCoordinator.start()
    }
    
}
