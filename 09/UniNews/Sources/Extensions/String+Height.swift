//
//  String+Height.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit


extension String
{
    func labelHeight(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label		    = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.font          = font
        label.text          = self
        label.sizeToFit()
        return label.frame.size.height
    }
    
    func textViewHeight(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        let textView  = UITextView(frame: CGRectMake(0, 0, width, CGFloat.max))
        textView.font = font
        textView.text = self
        textView.sizeToFit()
        let size = textView.sizeThatFits(textView.frame.size)
        return size.height
    }
}
