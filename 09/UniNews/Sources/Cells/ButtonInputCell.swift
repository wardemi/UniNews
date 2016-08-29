//
//  ButtonInputCell.swift
//  UniNews
//
//  Created by Canecom on 15/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class ButtonInputCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var buttonTouched: ((UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)

        self.button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.button.setBackgroundImage(UIImage(color: Uni.colors.green), forState: .Normal)
        
        self.button.layer.cornerRadius = 22
        self.button.layer.masksToBounds = true
    }

    @IBAction func buttonTouchedAction(sender: UIButton) {
        self.buttonTouched?(sender)
    }
}