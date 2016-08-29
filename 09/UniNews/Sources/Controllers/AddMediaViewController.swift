//
//  AddMediaViewController.swift
//  UniNews
//
//  Created by Canecom on 17/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit



class AddMediaViewController: BaseViewController
{

    var text: String!
    var link: String?
    var photo: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create news"

        self.register(nibNamed: "RoundedInputCell")
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        
        self.navigationItem.leftBarButtonItem = self.barButton("Back", action: #selector(self.back), tint: Uni.colors.blue)
        self.navigationItem.rightBarButtonItem = self.barButton("Ok", action: #selector(self.save), tint: Uni.colors.green)

    }

    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func save() {
        self.saveItem()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}


extension AddMediaViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RoundedInputCell", forIndexPath: indexPath)
        
        if let cell = cell as? RoundedInputCell {
            if indexPath.row == 0 {
                
                cell.iconView.image = UIImage(named: "PicWhite")
                cell.textLabel.text = "Tap to attach image"
                if let photo = self.photo {
                    cell.topConstraint.constant = 16
                    cell.imageView.image        = photo
                    cell.textLabel.text         = nil
                }
            }
            if indexPath.row == 1 {
                cell.iconView.image = UIImage(named: "LinkWhite")?.imageWithRenderingMode(.AlwaysTemplate)
                cell.textLabel.text = "Link"

                if let link = self.link {
                    cell.iconView.tintColor          = Uni.colors.blue
                    cell.textLabel.text              = link
                    cell.textLabel.textColor         = Uni.colors.blue
                }
            }
        }
        
        return cell
    }
}


extension AddMediaViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.width - 32, height: (self.photo == nil ? 44 : 288))
        }
        
        return CGSize(width: collectionView.bounds.width - 32, height: 44)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }
    
}

extension AddMediaViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            return self.chosePhotosSource()
        }
        self.addLink()
    }
}

extension AddMediaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func addLink() {
        let alertController = UIAlertController(title: "Add link", message: "Please enter your link", preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "Link"
        }

        let okAction = UIAlertAction(title: "OK", style: .Default) { action in
            let textField = alertController.textFields?.first
            
            self.link = textField?.text
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func chosePhotosSource() {
        
        let optionMenu = UIAlertController(title: nil, message: "Photos source", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { _ in
            self.showImagePicker(.Camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { _ in
            self.showImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { _ in
            
        }
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(photoLibraryAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func showImagePicker(source: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else { return }
        let imagePicker           = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.sourceType    = source;
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil);
        
        self.photo = image
        self.collectionView.reloadData()
    }
}




extension AddMediaViewController
{
    
    func saveItem() {
        
        defer {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.dismissViewControllerAnimated(true) {}
            }
        }

        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask    = NSSearchPathDomainMask.UserDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        guard let text = self.text else {
            return self.dismissViewControllerAnimated(true, completion: nil)
        }

        var assetUrl: NSURL?
        if let image = self.photo, let path = paths.first {
            let url = NSURL(fileURLWithPath: path).URLByAppendingPathComponent("image.png")

            if let _ = UIImagePNGRepresentation(image)?.writeToURL(url, atomically: true) {
                assetUrl = url
            }
        }

        let item = NewsRecord(content: text, image: assetUrl, url: self.link, author: Session.shared.current!)
        item.save { result in
            switch result {
            case .success(let item):
                print(item)
//                NSNotificationCenter.defaultCenter().postNotificationName("FeedItemCreatedNotification", object: nil)
                NSNotificationCenter.defaultCenter().postNotificationName("FeedItemCreatedNotification", object: nil, userInfo: ["item": item])
            case .error(let error):
                let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // ...
                }
                alertController.addAction(okAction)
            }
        }
    }
}

