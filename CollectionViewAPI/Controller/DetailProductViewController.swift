//
//  DetailProductViewController.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/5/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit
import SDWebImage

class DetailProductViewController: UIViewController {
    
    var id: Int?
    var detailProductViewModel: DetailsProductViewModel? {
        didSet {
            productImageView.sd_setImage(with: detailProductViewModel?.imageURL, completed: nil)
            descriptionTextLabel.text = detailProductViewModel?.decription
            priceTextLabel.text = detailProductViewModel?.price
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var priceTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductDetails()
    }
    
    private func fetchProductDetails() {
        Networking.shared.fetchDetail(with: id!) { (detailProduct, error) in
            if let error = error {
                print("request error", error)
                return
            }
            self.detailProductViewModel = DetailsProductViewModel(detailsProduct: detailProduct!)
        }
    }
}
