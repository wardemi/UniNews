//
//  RoundedInputCell.swift
//  UniNews
//
//  Created by Canecom on 17/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class RoundedInputCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var roundedView: UIView!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.reset()
    }
    
    func reset() {
        self.iconView.tintColor              = UIColor.whiteColor()
        self.imageView.backgroundColor       = UIColor.clearColor()
        self.textLabel.textColor             = UIColor.whiteColor()

        self.roundedView.backgroundColor     = Uni.colors.gray
        self.roundedView.layer.cornerRadius  = 22
        self.roundedView.layer.masksToBounds = true

        self.topConstraint.constant          = 8
        self.imageView.image                 = nil
        self.textLabel.text                  = nil
    }
}
