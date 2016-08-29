//
//  FeedCell.swift
//  UniNews
//
//  Created by Canecom on 11/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class FeedCell: UICollectionViewCell
{
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var profileView: UIView!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var button: UIButton!
    
    var buttonTouched: ((UIButton) -> Void)?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reset()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.reset()
    }
    
    
    func reset() {
        
        self.detailTextLabel.textColor            = Uni.colors.darkGray
        self.detailTextLabel.font                 = Uni.fonts.small

        self.profileView.backgroundColor          = Uni.colors.lightGray

        self.borderView.layer.borderWidth         = 1
        self.borderView.layer.borderColor         = self.profileView.backgroundColor?.CGColor
        self.borderView.layer.cornerRadius        = 10
        self.borderView.layer.masksToBounds       = true

        self.imageView.layer.cornerRadius         = 5
        self.imageView.layer.masksToBounds        = true

        self.profileImageView.backgroundColor     = UIColor.whiteColor()
        self.profileImageView.layer.cornerRadius  = 12
        self.profileImageView.layer.masksToBounds = true

        let image                                 = UIImage(named: "Link")?.scaled(to: CGSize(width: 24, height: 24))
        self.button.setImage(image, forState: .Normal)
        self.button.hidden                        = true
        self.button.userInteractionEnabled        = false
    }
    
}
