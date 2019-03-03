//
//  BaseViewController.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    func setupBaseObservables(baseViewModel: BaseViewModel) {
        
        setupSpinner(drivenBy: baseViewModel.isLoadingSubject)
        
        baseViewModel.errorSubject
            .flatMap({ Observable.from(optional: $0) })
            .subscribe(onNext: { error in
                print("Error = \(error)")
            }).disposed(by: disposeBag)
    }
}
