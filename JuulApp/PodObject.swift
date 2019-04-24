//
//  PodObject.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation
import RealmSwift

// Database Pod model 

class PodObject: Object {
    @objc dynamic var id : String = ""
    @objc dynamic var name : String? = ""
    @objc dynamic var poddescription : String? = ""
    @objc dynamic var price : Int = 0
    @objc dynamic var thumbnailURL : String? = ""
    @objc dynamic var imageURL : String? = ""
    @objc dynamic var isFavorite : Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }
    
    func setValues(_ pod:Pod, isUpdate: Bool = false, isFav: Bool = false) {
        if !isUpdate{
            id = pod.id ?? "1"
        }
        name = pod.name
        poddescription = pod.description
        price = pod.price ?? 0
        thumbnailURL = pod.thumbnailURL
        imageURL = pod.imageURL
        isFavorite = isFav
    }
    
    static func createOrUpdate(_ pod:Pod) {
        if let id = pod.id{
            if let object = DatabaseManager.shared.getObject(key: id) {
                DatabaseManager.shared.addData(object, pod: pod, isUpdate: true, isFav: object.isFavorite)
            }else{
                let podReal = PodObject()
                DatabaseManager.shared.addData(podReal, pod: pod)
            }
        }

        
    }
}
