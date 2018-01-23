//
//  RHProductViewController.swift
//  DanTang
//
//  Created by river on 2018/1/17.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

let collectionCellID = "RHCollectionViewCell"

class RHProductViewController: RHBaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout, RHCollectionViewCellDelegate{
    
    var products = [RHProduct]()
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        weak var weakSelf = self
        RHNetworkTool.shareNetworkTool.loadProductData { (products) in
            weakSelf!.products = products
            weakSelf!.collectionView!.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupCollectionView(){
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = view.backgroundColor
        let nib = UINib(nibName: String(describing:RHCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! RHCollectionViewCell
        cell.product = products[indexPath.item]
        cell.delegate = self
        return cell
    }
    
     // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("xxx")
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        print("like")
    }
    
    

}
