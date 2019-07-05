//
//  DetailsProductViewModel.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/5/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import Foundation

struct DetailsProductViewModel {
    
    let decription: String
    let name: String
    let imageURL: URL?
    let price: String
    
    init(detailsProduct: DetailProduct) {
        self.decription = detailsProduct.decription
        self.name = detailsProduct.name
        self.imageURL = detailsProduct.imageURL
        self.price = detailsProduct.price
    }
}
