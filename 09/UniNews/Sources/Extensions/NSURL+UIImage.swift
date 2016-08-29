//
//  NSURL+UIImage.swift
//  UniNews
//
//  Created by Canecom on 19/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit.UIImage


extension NSURL
{
    var localImageValue: UIImage? {
        if let imageData = NSData(contentsOfURL: self) {
            return UIImage(data: imageData)
        }
        return nil
    }
}
