//
//  PostsCoordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class PostsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var postModel: PostModel
    
    init(navigationController: UINavigationController, postModel: PostModel) {
        self.navigationController = navigationController
        self.postModel = postModel
    }
    
    deinit {
        print("\(String(describing: self)) was deinited")
    }
    
    func start() {
        let viewController = DetailsViewController.instantiate()
        viewController.viewModel = DetailsViewModel(postModel: postModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
