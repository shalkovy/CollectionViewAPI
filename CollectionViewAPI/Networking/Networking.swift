//
//  Networking.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/2/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

class Networking: NSObject {
    static let shared = Networking()
    
    let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    var products = [Product]()
//    var delegate: ProductsCollectionViewController?
    
    override init() {
        super.init()
//        self.makeRequest()
    }
    
    func makeRequest(completion: @escaping ([Product]?, Error?) -> ()) {
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)["products"]
                self.createProducts(from: json)
            } else {
                print("Error \(response.result.error!)")
            }
        }
    }
    
    func createProducts(from json: JSON) {
//        var array = [Product]()
        json.array?.forEach({ (json) in
//            let imageURL = URL(string: json["image"].stringValue)
//            print(json)
//            let image = UIImageView()
            let price = json["price"].stringValue
            let productID = json["product_id"].intValue
            
            let name = json["name"].stringValue
//            image.sd_setImage(with: imageURL)
            let product = Product(product_id: productID, name: name, price: price) // imageURL: imageURL)
            products.append(product)
            print(products.count)
        })
    }
}
