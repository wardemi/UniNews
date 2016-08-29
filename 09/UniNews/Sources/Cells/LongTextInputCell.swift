//
//  LongTextInputCell.swift
//  UniNews
//
//  Created by Canecom on 17/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


class LongTextInputCell: UICollectionViewCell
{
    
    @IBOutlet weak var textView: UITextView!
    
    var textViewDidEndEditing: ((UITextView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}


extension LongTextInputCell: UITextViewDelegate
{
    func textViewDidChange(textView: UITextView) {
        self.textViewDidEndEditing?(textView)
    }

    func textViewDidEndEditing(textView: UITextView) {
        
    }
}