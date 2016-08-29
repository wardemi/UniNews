//
//  ProfileImageCell.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class ProfileImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.borderColor   = Uni.colors.green.CGColor
        self.imageView.layer.borderWidth   = 3
        self.imageView.layer.cornerRadius  = 100
        self.imageView.layer.masksToBounds = true
    }
    
}