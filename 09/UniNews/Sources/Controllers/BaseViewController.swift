//
//  BaseViewController.swift
//  UniNews
//
//  Created by Canecom on 17/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func register(nibNamed name: String) {
        let nib = UINib(nibName: name, bundle: NSBundle.mainBundle())
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: name)
    }

}