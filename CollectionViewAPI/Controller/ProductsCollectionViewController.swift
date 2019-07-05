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
        return productViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ProductCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! ProductCollectionViewCell
        cell.backgroundColor = .white
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
