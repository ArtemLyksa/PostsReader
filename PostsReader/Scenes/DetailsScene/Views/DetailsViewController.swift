//
//  DetailsViewController.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: GenericTableView!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsOnLoad()
        setupObservables()
    }
    
    private func setupViewsOnLoad() {
        guard let viewModel = viewModel else { return }
        navigationItem.title = viewModel.data.title
    }
    
    private func setupObservables() {
        guard let viewModel = viewModel else { return }
        
        // Setup datasource
        tableView.configure(with: viewModel.data)
        viewModel.getDetails()
        
        // Setup base observables
        setupBaseObservables(baseViewModel: viewModel)
        
        // Setup base data observables
        setupBaseDataObservables(data: viewModel.data)
    }
    
}
