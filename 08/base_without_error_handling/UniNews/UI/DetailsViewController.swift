//
//  DetailsViewController.swift
//  UniNews
//
//  Created by Szloboda Zsolt on 18/05/16.
//  Copyright © 2016 Virgo Kft. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPostdate: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var labelDetails: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
