//
//  ProductFeed.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit
import RealmSwift

protocol ProductFeedDelegate: NSObjectProtocol {
    func modelDidUpdate()
}

class ProductFeed {
    private var service = JuulAPI()
    weak var delegate : ProductFeedDelegate?
    
    var pods = [PodObject]()
    var token : NotificationToken?
    var isFavoriteOn = false
    
    init() {
        token = DatabaseManager.shared.realm.observe({(notification, realm) in
            self.showFavoritePods(self.isFavoriteOn)
            self.delegate?.modelDidUpdate()
        })
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func fetchProducts(complition: @escaping ((Error?)->Void))  {
        service.getProducts() { result in
            switch result {
            case .success(let data):
                let pods = data.pods ?? [Pod]()
                _ = pods.compactMap{ PodObject.createOrUpdate($0) }
                self.loadPods()
                complition(nil)
                self.delegate?.modelDidUpdate()
            case .error(let error):
                complition(error)
                self.delegate?.modelDidUpdate()
            }
        }
    }
    private func loadPods() {
        pods = DatabaseManager.shared.getData()
    }
    
    func reload(complition: @escaping ((Error?)->Void)) {
        fetchProducts(complition: complition)
    }

    func showFavoritePods(_ isFavorite: Bool)  {
        isFavoriteOn = isFavorite
        if isFavorite{
            pods = DatabaseManager.shared.getFavoriteObjects() ?? [PodObject]()
        }else{
            pods = DatabaseManager.shared.getData()
        }
        self.delegate?.modelDidUpdate()
    }

    // Need to implement pagination to load more products dynamicaly
}
