//
//  AddViewController.swift
//  UniNews
//
//  Created by Canecom on 11/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit



class AddTextViewController: UIViewController
{
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    
    var animating: Bool = false
    var keyboardRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create news"

        self.navigationItem.leftBarButtonItem = self.barButton("Cancel", action: #selector(self.back), tint: Uni.colors.red)
        self.navigationItem.rightBarButtonItem = self.barButton("Next", action: #selector(self.save), tint: Uni.colors.blue)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keyboard),
                                                         name: UIKeyboardWillChangeFrameNotification,
                                                         object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.textView.becomeFirstResponder()
        }
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
    
    func scrollTo(frame: CGRect) {
        guard !self.animating else { return }
        
        self.animating = true

        self.bottomConstraint.constant = self.view.frame.size.height - frame.origin.y
        
        UIView.animateWithDuration(0.25, animations: { _ in
            //nothing to do...
        }, completion: { [weak self] finished in
            self?.view.layoutSubviews()
            self?.animating = false
        })
    }
    
    func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func save() {
        guard let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddMediaViewController") else {
            return
        }
        if let viewController = viewController as? AddMediaViewController {
            viewController.text = self.textView.text
        }
        self.showViewController(viewController, sender: nil)
    }
    
}

extension AddTextViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(textView: UITextView) {

    }

}


