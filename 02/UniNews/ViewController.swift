//
//  ViewController.swift
//  UniNews
//
//  Created by Canecom on 22/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


extension UIViewController {
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

