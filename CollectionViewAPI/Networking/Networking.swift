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

class Networking: NSObject {
    static let shared = Networking()
    
    let productsURL = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
    
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        Alamofire.request(productsURL, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)["products"]
                
                completion(self.createProducts(from: json), nil)
            } else {
                completion(nil, response.result.error!)
                print("Error \(response.result.error!)")
            }
        }
    }
    
    func createProducts(from json: JSON) -> [Product] {
        var array = [Product]()
        json.array?.forEach({ (json) in
            let imageURL = URL(string: json["image"].stringValue)
            let price = json["price"].stringValue
            let productID = json["product_id"].intValue
            let name = json["name"].stringValue
            
            let product = Product(product_id: productID, name: name, price: price, imageURL: imageURL)
            array.append(product)
        })
        return array
    }
}
