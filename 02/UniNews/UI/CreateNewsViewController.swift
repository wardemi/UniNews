//
//  CreateNewsViewController.swift
//  UniNews
//
//  Created by Szloboda Zsolt on 18/05/16.
//  Copyright © 2016 Virgo Kft. All rights reserved.
//

import UIKit

class CreateNewsViewController: UIViewController {
    @IBOutlet weak var imageProfile: UIImageView!

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPostdate: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var textfieldDetails: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionAddImageClicked(sender: AnyObject) {
    }
    @IBAction func actionDoneClicked(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
