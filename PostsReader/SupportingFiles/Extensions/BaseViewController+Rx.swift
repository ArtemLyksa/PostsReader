//
//  BaseViewController+Rx.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: BaseViewController {
    
    var errorAlert: Binder<Error> {
        return Binder(self.base) { viewController, error in
            let alert = UIAlertController(title: "Error".localized,
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok".localized, style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            })
            
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
