//
//  TitleCell.swift
//  UniNews
//
//  Created by Canecom on 15/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class TitleCell: UICollectionViewCell
{
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textLabel.font      = Uni.fonts.headline
        self.textLabel.textColor = Uni.colors.blue
    }
    
}
