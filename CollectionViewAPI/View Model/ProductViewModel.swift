//
//  ProductViewModel.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/5/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import Foundation

struct ProductViewModel {
    
    let productName: String
    let productPrice: String
    let productID: Int
    
    //Dependency injection
    init(product: Product) {
        self.productName = product.name
        self.productPrice = product.price
        self.productID = product.product_id
    }
    
}
