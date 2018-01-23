//
//  RHHomeCell.swift
//  DanTang
//
//  Created by river on 2018/1/23.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit

class RHHomeCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var placeholderBtn: UIButton!
    
    var homeItem: RHHomeItem? {
        didSet{
            let url = homeItem!.cover_image_url
            bgImageView.kf.setImage(with: URL(string: url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderBtn.isHidden = true
            }
            titleLabel.text = homeItem!.title
            favoriteBtn.setTitle(" " + String(homeItem!.likes_count!) + " ", for: .normal)
        }
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        favoriteBtn.layer.cornerRadius = favoriteBtn.height * 0.5
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.rasterizationScale = UIScreen.main.scale
        favoriteBtn.layer.shouldRasterize = true
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.shouldRasterize = true
        bgImageView.layer.rasterizationScale = UIScreen.main.scale
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
