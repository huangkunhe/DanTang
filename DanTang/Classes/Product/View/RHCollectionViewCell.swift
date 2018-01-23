//
//  RHCollectionViewCell.swift
//  DanTang
//
//  Created by river on 2018/1/18.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit
import Kingfisher

protocol RHCollectionViewCellDelegate:NSObjectProtocol {
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class RHCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: RHCollectionViewCellDelegate?
    
    @IBOutlet weak var placeholderBtn: UIButton!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var product: RHProduct? {
        didSet {
            let url = product!.cover_image_url!
            productImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                 self.placeholderBtn.isHidden = true
            }
            self.titleLabel.text = product?.name
            self.priceLabel.text = product?.price
            likeButton.setTitle(" " + String(product!.favorites_count!) + " ", for:.normal)
            
        }
    }
    
    
    
    

}
