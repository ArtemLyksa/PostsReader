//
//  Coordinator.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

protocol Coordinator {
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
