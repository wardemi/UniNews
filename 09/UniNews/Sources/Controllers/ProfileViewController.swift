//
//  ProfileViewController.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit
import CloudKit


class ProfileViewController: BaseViewController
{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var animating: Bool = false
    var keyboardRect: CGRect?
    

    var account: AccountRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.register(nibNamed: "EmptyCell")
        self.register(nibNamed: "ProfileImageCell")
        self.register(nibNamed: "TextInputCell")
        self.register(nibNamed: "ButtonInputCell")
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        
        self.navigationItem.rightBarButtonItem = self.barButton("Ok", action: #selector(self.save), tint: Uni.colors.green)
        self.navigationItem.leftBarButtonItem  = self.barButton("Cancel", action: #selector(self.close), tint: Uni.colors.red)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboard),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
        
        
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()

        Session.shared.current?.fetchLatest { result in
            switch result {
            case .success(let item):
                self.account = AccountRecord(record: item)
         
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self.activityIndicator.hidden = true
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }

            case .error(let error):
                self.display(error)
            }
        }
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func keyboard(notification: NSNotification) {
        guard
            let keyboardRect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            else {
                return
        }
        
        if self.keyboardRect != keyboardRect {
            self.keyboardRect = keyboardRect
        }
        
        self.scrollTo(self.keyboardRect!)
    }

    func save() {
        

        guard let record = self.account?.record else { return }
        
        
        var name: String? {
            return (self.view.viewWithTag(3) as? UITextField)?.text
        }
        var email: String? {
            return (self.view.viewWithTag(4) as? UITextField)?.text
        }
        var password: String? {
            return (self.view.viewWithTag(5) as? UITextField)?.text
        }
        
        record.setObject(email, forKey: "email")
        record.setObject(name, forKey: "name")
        record.setObject(password, forKey: "password")

        if let fileUrl = self.account?.avatar {
            record.setObject(CKAsset(fileURL: fileUrl), forKey: "avatar")
        }

        record.save { result in
            switch result {
            case .success(_):
                return NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            case .error(let error):
                self.display(error)
            }
        }
    }

    func display(error: ErrorType) {
        let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(okAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
    
}

extension ProfileViewController
{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.collectionView?.endEditing(true)
    }
    
    func scrollTo(frame: CGRect) {
        guard
            let collectionView = self.collectionView where
            !collectionView.dragging &&
                !collectionView.decelerating &&
                !self.animating
            else
        {
            return
        }
        
        self.animating = true

        let y = collectionView.contentSize.height - frame.origin.y
        UIView.animateWithDuration(0.25, animations: { [weak collectionView] in
            collectionView?.setContentOffset(CGPoint(x: 0, y: y), animated: false)
        }, completion: { [weak self] finished in
            self?.animating = false
        })
    }
    
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    func chosePhotosSource(sourceView: UIView) {
        
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
        
        optionMenu.popoverPresentationController?.sourceView = sourceView
        optionMenu.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 240)
        
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
        
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask    = NSSearchPathDomainMask.UserDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        
        var assetUrl: NSURL?
        if let image = image, let path = paths.first {
            let url = NSURL(fileURLWithPath: path).URLByAppendingPathComponent("avatar.png")
            
            if let _ = UIImagePNGRepresentation(image)?.writeToURL(url, atomically: true) {
                assetUrl = url
            }
        }
        
        self.account?.avatar = assetUrl
        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.collectionView.reloadData()
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ProfileImageCell {
                return self.chosePhotosSource(cell.imageView)
            }
        }
    }
}



extension ProfileViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.account == nil {
            return 0
        }
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 7 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EmptyCell", forIndexPath: indexPath)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileImageCell", forIndexPath: indexPath)

            if let cell = cell as? ProfileImageCell {

                cell.imageView.image           = self.account?.avatar?.localImageValue ?? UIImage(named: "DefaultUser")
                cell.imageView.backgroundColor = UIColor.lightGrayColor()
            }
            
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ButtonInputCell", forIndexPath: indexPath)
            
            if let cell = cell as? ButtonInputCell {
                cell.button.setTitle("logout".uppercaseString, forState: .Normal)
                cell.buttonTouched = { [weak self] button in
                    guard let `self` = self else { return }
                    var uncommentThis: Void?
//                    Session.shared.current = nil
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            return cell
        }

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TextInputCell", forIndexPath: indexPath)
        
        if let cell = cell as? TextInputCell {

            if indexPath.row == 3 {
                cell.textField.placeholder = "Name"
                cell.textField.text = self.account?.name
            }
            if indexPath.row == 4 {
                cell.textField.placeholder = "Email"
                cell.textField.text = self.account?.email
            }
            if indexPath.row == 5 {
                cell.textField.placeholder = "Password"
                cell.textField.text = self.account?.password
                cell.textField.secureTextEntry = true
            }
            
            cell.textField.tag = indexPath.row
            cell.textFieldShouldReturnBlock = { [weak self, weak indexPath] textField in
                guard let `self` = self, let indexPath = indexPath else { return }
                
                if let nextTextField = self.collectionView.viewWithTag(indexPath.row+1) {
                    nextTextField.becomeFirstResponder()
                }
                else {
                    textField.endEditing(true)
                }
            }

            cell.textFieldDidChangeBlock = { [weak self, weak indexPath] textField in
                guard let `self` = self, let indexPath = indexPath else { return }

                if indexPath.row == 3 {
                    self.account?.name = textField.text
                }
                if indexPath.row == 4 {
                    self.account?.email = textField.text ?? ""
                }
                if indexPath.row == 5 {
                    self.account?.password = textField.text ?? ""
                }
            }
        }
        
        return cell
    }
}


extension ProfileViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if indexPath.row == 0 || indexPath.row == 2 {

            let height = collectionView.bounds.height + collectionView.bounds.origin.y

            let emptySpace = height - 6*10 - 5*44 - 200

            return CGSize(width: collectionView.bounds.width - 32, height: emptySpace / 2.0)
        }
        if indexPath.row == 1 {
            return CGSize(width: collectionView.bounds.width - 32, height: 200)
        }
        return CGSize(width: collectionView.bounds.width - 32, height: 44)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
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




