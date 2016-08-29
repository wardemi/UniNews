//
//  Uni.swift
//  UniNews
//
//  Created by Canecom on 16/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import UIKit



public func dlog<T>(@autoclosure object:  () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
#if DEBUG

    var fileName = "unknown"
    if let name = NSURL(string: file)?.lastPathComponent?.componentsSeparatedByString(".").first {
        fileName = name
    }
    print("[DLOG]: \(fileName).\(function)[\(line)]: \(object())\n", terminator: "")

#endif
}


enum Uni
{

    enum colors {
        static var green: UIColor { return UIColor(red:0.31, green:0.80, blue:0.77, alpha:1.00) }
        static var red: UIColor { return UIColor(red:0.93, green:0.40, blue:0.40, alpha:1.00) }
        static var blue: UIColor { return UIColor(red:0.41, green:0.60, blue:0.93, alpha:1.00) }
        static var orange: UIColor { return UIColor(red:0.93, green:0.60, blue:0.43, alpha:1.00) }

        static var darkGray: UIColor { return UIColor(red:0.59, green:0.59, blue:0.59, alpha:1.00) }
        static var gray: UIColor { return UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00) }
        static var lightGray: UIColor { return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00) }
    }

    enum fonts {
        static var headline: UIFont { return UIFont.systemFontOfSize(24) }
        static var small: UIFont { return UIFont.systemFontOfSize(12) }
    }
}
