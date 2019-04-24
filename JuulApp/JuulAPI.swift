//
//  JuulAPI.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation

final class JuulAPI: NSObject {
    let service: Service
    
    convenience override init() {
        self.init(service: NetworkService())
    }
    
    init(service: Service) {
        self.service = service
    }
    
    func getProducts(request: Requests = APIRequests.product, _ completion: @escaping (Result<Products>) -> Void) {
        
        service.get(request: request, urlParameters: [:]) { result in
            switch result {
            case .success(let data):
                do {
                    let products : Products = try JSONDecoder().decode(Products.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(products))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completion(.error(error))
                }
            }
        }
        
    }
}

enum APIRequests: String, Requests {
    case product = "https://s3.us-east-2.amazonaws.com/juul-coding-challenge/products.json"

    var url: URL {
        return URL(string: rawValue)!
    }
}
