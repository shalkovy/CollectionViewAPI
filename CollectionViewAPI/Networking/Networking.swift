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
    var detailProduct: DetailProduct?
    
    func fetchProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)["products"]
                completion(self.createProducts(from: json), nil)
            } else {
                completion(nil, response.result.error!)
                print("Error \(response.result.error!)")
            }
        }
    }
    
    private func createProducts(from json: JSON) -> [Product] {
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
    
    func fetchDetail(with id: Int, completion: @escaping (DetailProduct?, Error?) -> ()) {
        let url = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(id)/detail"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                completion(self.createDetailProduct(from: json), nil)
            } else {
                completion(nil, response.result.error!)
                print("Error \(response.result.error!)")
            }
        }
    }
    
    // TODO: - try to make functions more generic
    
    private func createDetailProduct(from json: JSON) -> DetailProduct {
        let productID = json["product_id"].intValue
        let description = json["description"].stringValue
        let price = json["price"].stringValue
        let imageURL = URL(string: json["image"].stringValue)
        let name = json["name"].stringValue
        
        let detailProduct = DetailProduct(decription: description,
                                          product_id: productID,
                                          name: name,
                                          imageURL: imageURL,
                                          price: price)
        return detailProduct
    }
}
