//
//  Persistable.swift
//  PostsReader
//
//  Created by Artem Lyksa on 3/4/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
    
    associatedtype ManagedObject: Object
    associatedtype Query: QueryType
    
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

protocol QueryType {
    var predicate: NSPredicate? { get }
}

class Container {
    
    private let realm: Realm
    
    convenience init() throws {
        try self.init(realm: Realm())
    }
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func add<T: Persistable>(_ value: T, update: Bool) throws {
        try realm.write {
            realm.add(value.managedObject(), update: update)
        }
    }
    
    func add<T: Persistable>(_ value: [T], update: Bool) throws {
        try realm.write {
            realm.add(value.encodeItems(), update: update)
        }
    }
    
    func values<T: Persistable> (_ type: T.Type, matching query: T.Query? = nil) -> [T] {
        var results = realm.objects(T.ManagedObject.self)
        if let predicate = query?.predicate {
            results = results.filter(predicate)
        }
        return FetchedResults(results: results).values()
    }
}

class FetchedResults<T: Persistable> {
    let results: Results<T.ManagedObject>
    
    var count: Int {
        return results.count
    }
    init(results: Results<T.ManagedObject>) {
        self.results = results
    }
    func value(at index: Int) -> T {
        return T(managedObject: results[index])
    }
    func values() -> [T] {
        return results.toArray().map({ T(managedObject: $0) })
    }
}

extension Array where Element == Object {
    
    func decodeItems<T: Persistable>() -> [T] {
        return self.map({ T.init(managedObject: $0 as! T.ManagedObject) })
    }
}

extension Array where Element: Persistable {
    
    func encodeItems() -> [Object] {
        return self.map({ $0.managedObject() })
    }
}
