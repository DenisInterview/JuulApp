//
//  DetailViewController.swift
//  JuulApp
//
//  Created by Denis Kalashnikov on 4/11/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var pod : PodObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        if let pod = pod {
            if let imageURL = pod.imageURL, let url = URL(string: imageURL){
                productImageView.sd_setImage(with: url, completed: nil)
            }
            self.title = pod.name
            priceLabel.text = pod.price.getPriceUSDString()
            descriptionLabel.text = pod.poddescription
        }
    }

}
