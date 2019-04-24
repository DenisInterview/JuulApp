//
//  Result.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
