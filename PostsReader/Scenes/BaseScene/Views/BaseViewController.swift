//
//  BaseViewController.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController, Storyboarded {
    
    let disposeBag = DisposeBag()
    
    private var rightGenericBarButton: GenericBarButton?
    
    func setupBaseObservables(baseViewModel: BaseViewModel) {
        
        setupSpinner(drivenBy: baseViewModel.isLoadingSubject)
        
        baseViewModel.error
            .flatMap({ Observable.from(optional: $0) })
            .bind(to: rx.errorAlert)
            .disposed(by: disposeBag)
    }
    
    func setupBaseDataObservables(data: GenericTableViewData) {
        data.rightBarButton
            .flatMap({ Observable.from(optional: $0) })
            .subscribe(onNext: { [weak self] genericBarButton in
                guard let self = self else { return }
                self.rightGenericBarButton = genericBarButton
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: genericBarButton.title,
                                                                         style: .done,
                                                                         target: self,
                                                                         action: #selector(self.rightBarButtonAction))
            }).disposed(by: disposeBag)
    }
    
    @objc private func rightBarButtonAction() {
        rightGenericBarButton?.action()
    }
}
