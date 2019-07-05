//
//  ProductsCollectionViewController.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/2/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit
//import SDWebImage

private let reuseIdentifier = "Cell"

class ProductsCollectionViewController: UICollectionViewController {
    
//    var networking = Networking.shared
    var productViewModels = [ProductViewModel]() {
        didSet {
            print(productViewModels.count)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCellWidth()
        makeRequest()
    }
    
    func makeRequest() {
        Networking.shared.makeRequest { (products, error) in
            if let error = error {
                print("request error", error)
                return
            }
            self.productViewModels = products?.map({ return ProductViewModel(product: $0)}) ?? []
            self.collectionView.reloadData()
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModels.count //networking.products.count 
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! ProductCollectionViewCell
        cell.backgroundColor = .white
        let product = productViewModels[indexPath.item]
        cell.product = product
        return cell
        
    }
    
    func updateCell(_ cell: ProductCollectionViewCell, at index: Int) {
//        guard !networking.products.isEmpty else { return }
//        let product = networking.products[index]
//        cell.productImageView.sd_setImage(with: product.imageURL)
//        cell.priceLabel.text = String(product.price)
//        cell.productNameLabel.text = product.name
//        collectionView.reloadData()
    }
    
    func setCellWidth() {
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
//    func reloadData() {
//        collectionView.reloadData()
//    }
}
