//
//  Session.swift
//  UniNews
//
//  Created by Canecom on 19/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import Foundation
import CloudKit


class Session
{

    static let shared = Session()

    private static let Key = "current-record"

    private init() {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(Session.Key) as? NSData {
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            unarchiver.requiresSecureCoding = true

            if
                let unarchivedRecord = CKRecord(coder: unarchiver)
            {
                self._current = unarchivedRecord
            }
        }
    }

    private var _current: CKRecord?

    var current: CKRecord? {
        get {
            return _current
        }
        set {
            _current = newValue
            var data: NSData?

            if let record = _current {
                let archivedData = NSMutableData()
                let archiver = NSKeyedArchiver(forWritingWithMutableData: archivedData)
                archiver.requiresSecureCoding = true
                record.encodeSystemFieldsWithCoder(archiver)
                archiver.finishEncoding()
                data = archivedData
            }
            
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: Session.Key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    var isLoggedIn: Bool {
        return self.current != nil
    }

}