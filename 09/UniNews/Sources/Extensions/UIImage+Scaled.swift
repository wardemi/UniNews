//
//  UIImage+Scaled.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


extension UIImage {
    
    func scaled(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
