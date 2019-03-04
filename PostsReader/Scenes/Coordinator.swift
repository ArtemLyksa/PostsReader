//
//  Coordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import RxSwift

protocol Coordinator {
    
    /// Using to keep track of navigation back
    var pop: Observable<Void> { get }
    var disposeBag: DisposeBag { get }
    
    /// Using to keep references to the child coordinators
    var childCoordinators: [Coordinator] { get }
    
    var navigationController: UINavigationController { get }
    func start()
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
