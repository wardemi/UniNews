//
//  AccountRecord.swift
//  UniNews
//
//  Created by Canecom on 10/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import Foundation
import CloudKit


final class AccountRecord: CloudKitRecord {
    
    static var recordName: String { return "Account" }
    let record: CKRecord
    
    
    var email: String
    var password: String

    var name: String?
    var avatar: NSURL?
    

    init(record: CKRecord) {
        self.record   = record

        self.email    = record.objectForKey("email") as! String
        self.password = record.objectForKey("password") as! String

        self.name     = record.objectForKey("name") as? String
        self.avatar   = (record.objectForKey("avatar") as? CKAsset)?.fileURL
    }
    
    
    convenience init(email: String, password: String, name: String? = nil, avatar: NSURL? = nil, existingRecord: CKRecord? = nil) {        
        var record = CKRecord(recordType: AccountRecord.recordName)
        if let rec = existingRecord {
            record = rec
        }

        record.setObject(email, forKey: "email")
        record.setObject(name, forKey: "name")
        record.setObject(password, forKey: "password")

        if let fileUrl = avatar {
            record.setObject(CKAsset(fileURL: fileUrl), forKey: "avatar")
        }
        self.init(record: record)
    }
    
    

}


extension AccountRecord {

    static func register(email: String, pass: String, completion: (CloudKitResult<AccountRecord>) -> Void) {
        let account = AccountRecord(email: email, password: pass)
        account.save(completion)
    }

    static func login(email: String, pass: String, completion: (CloudKitResult<AccountRecord>) -> Void) {
        let defaultContainer = CKContainer.defaultContainer()
        let publicDatabase   = defaultContainer.publicCloudDatabase
        let predicate        = NSPredicate(format: "(email == %@ AND password == %@)", email, pass)
        let query            = CKQuery(recordType: self.recordName, predicate: predicate)

        publicDatabase.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                return completion(.error(error!))
            }
            let data = results ?? []
            let object = data.first.map { self.init(record: $0) }

            if let account = object {
                return completion(.success(account))
            }
            return completion(.error(CloudKitError.noRecord))
        }
    }

}