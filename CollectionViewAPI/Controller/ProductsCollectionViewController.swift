//
//  ProductsCollectionViewController.swift
//  CollectionViewAPI
//
//  Created by Dima Shelkov on 7/2/19.
//  Copyright © 2019 Dima Shelkov. All rights reserved.
//

import UIKit

class ProductsCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private var productViewModels = [ProductViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCellWidth()
        fetchProductsData()
    }
    
    // MARK: - Navigation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        let product = productViewModels[indexPath.item]
        let id = product.productID
        
        let detailVC = segue.destination as? DetailProductViewController
        detailVC?.navigationItem.title = product.productName
        detailVC?.id = id
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! ProductCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let product = productViewModels[indexPath.item]
        cell.product = product
        return cell
    }
    
    // MARK: - Methods
    private func fetchProductsData() {
        Networking.shared.fetchProducts { (products, error) in
            if let error = error {
                print("request error", error)
                return
            }
            self.productViewModels = products?.map({ return ProductViewModel(product: $0)}) ?? []
            self.collectionView.reloadData()
        }
    }
    
    private func setCellWidth() {
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
}
