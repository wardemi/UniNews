//
//  RegisterViewController.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class RegisterViewController: BaseViewController
{
        
    var animating: Bool = false
    var keyboardRect: CGRect?
    
    var email: String? {
        return (self.view.viewWithTag(4) as? UITextField)?.text
    }
    var password: String? {
        return (self.view.viewWithTag(5) as? UITextField)?.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.register(nibNamed: "EmptyCell")
        self.register(nibNamed: "TitleCell")
        self.register(nibNamed: "LogoCell")
        self.register(nibNamed: "TextInputCell")
        self.register(nibNamed: "ButtonInputCell")
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboard),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
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

}

extension RegisterViewController
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


extension RegisterViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 7 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EmptyCell", forIndexPath: indexPath)
            return cell
        }
        
        if indexPath.row == 1  {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TitleCell", forIndexPath: indexPath)
            
            if let cell = cell as? TitleCell {
                cell.textLabel.text      = "register()"
            }
            
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LogoCell", forIndexPath: indexPath)
            
            if let cell = cell as? LogoCell {
                cell.imageView.image = UIImage(named: "Logo")
                
                print(cell.imageView.image?.size)
                
            }
            
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ButtonInputCell", forIndexPath: indexPath)
            
            if let cell = cell as? ButtonInputCell {
                cell.button.setTitle("register".uppercaseString, forState: .Normal)
                cell.buttonTouched = { [weak self] button in
                    guard let `self` = self else { return }
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    guard let email = self.email, let pass = self.password else {
                        return
                    }

                    AccountRecord.register(email, pass: pass, completion: { result in
                        switch result {
                        case .success(let item):
                            
                            Session.shared.current = item.record
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }
                            
                        case .error(let error):
                            
                            let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .Alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                                // ...
                            }
                            alertController.addAction(okAction)
                            
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.view.endEditing(true)
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
            
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TextInputCell", forIndexPath: indexPath)
        
        if let cell = cell as? TextInputCell {
            if indexPath.row == 4 {
                cell.textField.placeholder = "Email"
            }
            if indexPath.row == 5 {
                cell.textField.placeholder = "Password"
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
            
        }
        
        return cell
    }
}


extension RegisterViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if indexPath.row == 0 || indexPath.row == 3 {
            let emptySpace = collectionView.bounds.size.height - 6*10 - 4*44 - 2*64
            
            return CGSize(width: collectionView.bounds.width - 32, height: emptySpace / 2.0)
        }
        if indexPath.row == 1 || indexPath.row == 2 {
            return CGSize(width: collectionView.bounds.width - 32, height: 64)
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



