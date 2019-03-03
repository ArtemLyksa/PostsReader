//
//  PostsViewController.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class PostsViewController: BaseViewController {

    @IBOutlet weak var tableView: GenericTableView!
    private let viewModel = PostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }
    
    private func setupObservables() {
        tableView.setDataSourceObservable(sections: viewModel.sections.asObservable())
        viewModel.getPosts()
    }
}
