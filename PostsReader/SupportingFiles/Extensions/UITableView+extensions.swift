//
//  UITableView+extensions.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

extension UITableView {
    
    func getCell<T>(ofType type: T.Type) -> T {
        
        let nibName = "\(type)"
        var cell = dequeueReusableCell(withIdentifier: nibName) as? T
        
        if cell == nil {
            register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
            cell = dequeueReusableCell(withIdentifier: nibName) as? T
        }
        
        return cell!
    }
}

