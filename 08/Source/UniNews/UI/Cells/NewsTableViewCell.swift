//
//  NewsTableViewCell.swift
//  UniNews
//
//  Created by Szloboda Zsolt on 18/05/16.
//  Copyright © 2016 Virgo Kft. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPostdate: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var imageNews: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
