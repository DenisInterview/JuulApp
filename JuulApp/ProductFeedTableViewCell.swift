//
//  ProductFeedTableViewCell.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit
import SDWebImage


class ProductFeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
   
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    static let height = 350
    static let id = "ProductFeedCollectionViewCell"
    private var pod: PodObject?
    
    private let inset = CGFloat(100)
    private let favColor = UIColor(red: 56.0/255.0, green: 173.0/255.0, blue: 169.0/255.0, alpha: 1.0)
    private let defaultColor = UIColor(red: 87.0/255.0, green: 104.0/255.0, blue: 110.0/255.0, alpha: 1.0)

    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteButton.layer.cornerRadius = 4
        favoriteButton.clipsToBounds = true
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 4.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.4
        
        //makes the cell round
        let containerView = self.contentView
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(_ pod:PodObject) {
        self.pod = pod
        if let thumbURL = pod.thumbnailURL, let url = URL(string: thumbURL){
            productImageView.sd_setImage(with: url, completed: nil)
        }
        productNameLabel.text = pod.name
        productPriceLabel.text = pod.price.getPriceUSDString()
        setButtonFavorite(pod.isFavorite)
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if let pod = pod, let object = DatabaseManager.shared.getObject(key: pod.id) {
            DatabaseManager.shared.setFavoriteFlag(object, isFav: !pod.isFavorite)
            setButtonFavorite(pod.isFavorite)
        }
        
    }
    
    func setButtonFavorite(_ isFav: Bool) {
        favoriteButton.backgroundColor = isFav ? favColor : defaultColor
        favoriteButton.setTitle(isFav ? "Favorite": "Add Favorite", for: .normal)
    }
}
