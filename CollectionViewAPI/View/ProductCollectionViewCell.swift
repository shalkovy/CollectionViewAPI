//
//  ProductCollectionViewCell.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/3/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    var product: ProductViewModel! {
        didSet {
            productNameLabel.text = product.productName
            priceLabel.text = "\(product.productPrice)"
            productImageView.sd_setImage(with: product.imageURL, completed: nil)
        }
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
