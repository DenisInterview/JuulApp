//
//  DatabaseManager.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    let realm = try! Realm()
    
    func getData() -> [PodObject] {
        let result = realm.objects(PodObject.self)
        return Array(result)
    }
    
    func getObject(key: String) -> PodObject? {
        let scope = realm.objects(PodObject.self).filter("id == %@", key)
        return scope.first
    }
    
    func getFavoriteObjects() -> [PodObject]? {
        let scope = realm.objects(PodObject.self).filter("isFavorite == %@", true)
        return scope.compactMap{ $0 }
    }
    
    func addData(_ object: PodObject, pod:Pod, isUpdate: Bool = false, isFav: Bool = false) {
        try! realm.write {
            object.setValues(pod, isUpdate: isUpdate, isFav: isFav)
            realm.add(object, update: true)
            print("Added new object")
        }
    }
    
    func setFavoriteFlag(_ object: PodObject, isFav: Bool) {
        try! realm.write {
            object.isFavorite = isFav
            realm.add(object, update: true)
            print("Set favorite flag \(isFav)" )
        }
    }
    
    func deleteData(_ object: PodObject) {
        try! realm.write {
            realm.delete(object)
            print("Delete object")
        }
    }
}

