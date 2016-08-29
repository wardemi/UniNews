//
//  String+isValidUrl.swift
//  UniNews
//
//  Created by Canecom on 19/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import Foundation


extension String
{
    var isValidUrl: Bool {
        let regExp = "(.+)://((\\w)*|([0-9]*)|([-|_|@|:])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        return predicate.evaluateWithObject(self)
    }
}