//
//  ProductsCollectionViewController.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/2/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProductsCollectionViewController: UICollectionViewController {
    
    var networking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        networking.makeRequest()
        cellWidth()
        networking.delegate = self

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
        return networking.products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ProductCollectionViewCell {
//            updateCell(cell, at: indexPath.item)
//            cell.backgroundColor = .white
//            return cell
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.backgroundColor = .white
//        cell.productNameLabel.text = "aa"
        updateCell(cell, at: indexPath.item)
//        print(cell.productNameLabel.text as Any)
        return cell
        
    }
    
    func updateCell(_ cell: ProductCollectionViewCell, at index: Int) {
        guard !networking.products.isEmpty else { return }
        let product = networking.products[index]
        cell.productImageView = product.image
        cell.priceLabel.text = String(product.price)
        cell.productNameLabel.text = product.name
//        collectionView.reloadData()
    }
    
    func cellWidth() {
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
