//
//  Products.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation

class Products: Codable {
    let pods: [Pod]?
    
    init(pods: [Pod]?) {
        self.pods = pods
    }
}

class Pod: Codable {
    let id, name, description: String?
    let price: Int?
    let thumbnailURL, imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case thumbnailURL = "thumbnail_url"
        case imageURL = "image_url"
    }
    
    init(id: String?, name: String?, description: String?, price: Int?, thumbnailURL: String?, imageURL: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.thumbnailURL = thumbnailURL
        self.imageURL = imageURL
    }
}

extension Int{
    func getPriceUSDString() -> String {
        return "$\(Double(self) / 100.0)"
    }
    
}
