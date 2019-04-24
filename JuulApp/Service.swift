//
//  Service.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation

protocol Requests {
    var url: URL { get }
}

protocol Service {
    func get(request: Requests, urlParameters: [String:String], completion: @escaping (Result<Data>) -> Void)
}

// urlParameters - for network request with parameters

final class NetworkService: Service {
    func get(request: Requests, urlParameters: [String:String], completion: @escaping (Result<Data>) -> Void) {
        var urlStr = request.url.absoluteString
        if urlParameters.count > 0{
            urlStr += "?"
            for param in urlParameters {
                urlStr += "\(param.key)=\(param.value)"
                print(urlStr)
            }
        }
        guard let url = URL(string: urlStr) else {
            completion(.error(ServiceError.invalidData))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                completion(.error(error))
                return
            }
            guard let data = data else {
                completion(.error(ServiceError.invalidData))
                return
            }
            completion(.success(data))
            }.resume()
    }
}

enum ServiceError: Error {
    case invalidData
}

