//
//  RealmStorage.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import RealmSwift
import Realm
import Foundation

class RealmStorage<T: Object> where T: PrimaryKeyAware {
    let realm: Realm
    
    init() {
            realm = try! Realm()
    }
    
    func saveAll(_ objects: [T]){
        try! realm.write {
            realm.add(objects, update: true)
        }
    }
    
    func save(_ object: T){
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func getAll() -> Results<T>{
        return realm.objects(T.self)
    }
    
    func getById(id: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: id)
    }
    
    func deleteAll(){
        let result = realm.objects(T.self)
        realm.delete(result)
    }
    
}
