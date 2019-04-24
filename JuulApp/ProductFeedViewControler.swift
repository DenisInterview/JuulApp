//
//  ProductFeedViewControler.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class ProductFeedViewControler: UIViewController, CollectionViewPushAndPoppable {
    var sourceCell: UICollectionViewCell?
    
    let model = ProductFeed()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.reload { (error) in
            //show user error
        }
    }
    
    
    @IBAction func segmentAction(_ sender: Any) {
        model.showFavoritePods(segmentControl.selectedSegmentIndex == 1)
    }
    
}

extension ProductFeedViewControler: ProductFeedDelegate{
    func modelDidUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProductFeedViewControler: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.pods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductFeedCollectionViewCell.id, for: indexPath) as! ProductFeedCollectionViewCell
        cell.setup(model.pods[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: "DetailViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.pod = model.pods[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        sourceCell = cell
        
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

extension ProductFeedViewControler: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopInAndOutAnimator(operation: operation)
    }
}
