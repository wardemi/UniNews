//
//  TextInputCell.swift
//  UniNews
//
//  Created by Canecom on 15/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class TextInputCell: UICollectionViewCell
{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textBakground: UIView!
    
    
    var textFieldDidChangeBlock: ((UITextField) -> Void)?
    var textFieldShouldReturnBlock: ((UITextField) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        self.textBakground.layer.borderColor   = Uni.colors.gray.CGColor
        self.textBakground.layer.borderWidth   = 1
        self.textBakground.layer.cornerRadius  = 22
        self.textBakground.layer.masksToBounds = true

        self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), forControlEvents: .EditingChanged)
    }
    
}


extension TextInputCell: UITextFieldDelegate
{
    func textFieldDidChange(textField: UITextField) {
       self.textFieldDidChangeBlock?(textField)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textFieldShouldReturnBlock?(textField)
        return false
    }
}