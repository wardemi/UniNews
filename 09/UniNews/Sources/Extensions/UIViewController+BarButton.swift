//
//  UIViewController+BarButton.swift
//  UniNews
//
//  Created by Canecom on 23/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit.UIViewController


extension UIViewController {
    
    func barButton(named: String, action: Selector, tint: UIColor) -> UIBarButtonItem {
        let image = UIImage(named: named)?.scaled(to: CGSize(width: 24, height: 24))
        let item = UIBarButtonItem(image: image, style: .Plain, target: self, action: action)
        item.tintColor = tint
        return item
    }
    
}
