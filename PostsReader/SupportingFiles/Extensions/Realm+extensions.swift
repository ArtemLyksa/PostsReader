//
//  Realm+extensions.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/3/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    class func safeInit() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        } catch {
            print("Found an error during realm initialization = \(error)")
            return nil
        }
    }
    
    func safeWrite(_ block: (() -> Swift.Void)) {
        do {
            try write(block)
        } catch {
            print("Found an error during realm writing operation = \(error)")
        }
    }
    
}
