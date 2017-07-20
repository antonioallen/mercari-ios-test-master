//
//  ViewController.swift
//  Mercari
//
//  Created by Antonio Allen on 7/13/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Vars
    var products:[Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set Delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Get Products
        ProductManager.getProducts { (products, errorMessage) in
            self.products = products
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = products[indexPath.item]
        print("Product: \(product.id) Selected")
        //Do Something With Product
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = products[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        
        cell.nameLabel.text = product.name
        cell.priceButton.setTitle("$\(product.price)", for: .normal)
        cell.imageView.kf.setImage(with: URL(string: product.photoURL), options: [.transition(.fade(0.5))])
        
        switch product.status {
        case .soldOut:
            cell.soldImageView.isHidden = false
            break
        default:
            cell.soldImageView.isHidden = true
            break
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 125)

    }

}

