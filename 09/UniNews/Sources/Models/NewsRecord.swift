//
//  NewsRecord.swift
//  UniNews
//
//  Created by Canecom on 10/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import Foundation
import CloudKit


final class NewsRecord: CloudKitRecord {
    
    static var recordName: String { return "News" }
    let record: CKRecord

    let content: String
    let url: String?
    let image: NSURL?
    let author: CKReference
    
    var authorObject: AccountRecord?

    init(record: CKRecord) {
        self.record  = record

        self.content = record.objectForKey("content") as! String
        self.url     = record.objectForKey("url") as? String
        self.image   = (record.objectForKey("image") as? CKAsset)?.fileURL
        
        
        self.author  = record.objectForKey("author") as! CKReference
    }

    
    convenience init(date: NSDate = NSDate(), content: String, url: String? = nil, image: NSURL? = nil, author: CKRecord) {
        let record = CKRecord(recordType: NewsRecord.recordName)
        
        record.setObject(content, forKey: "content")
        record.setObject(url, forKey: "url")
        record.setObject(CKReference(recordID: author.recordID, action: .DeleteSelf), forKey: "author")

        if let fileUrl = image {
            record.setObject(CKAsset(fileURL: fileUrl), forKey: "image")
        }

        self.init(record: record)
    }
    
    

}

extension NewsRecord
{
    static func fetchAll(completion: (CloudKitResult<[NewsRecord]>) -> Void) {
        let defaultContainer = CKContainer.defaultContainer()
        let publicDatabase   = defaultContainer.publicCloudDatabase
        let predicate        = NSPredicate(value: true)
        let query            = CKQuery(recordType: self.recordName, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        publicDatabase.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                return completion(.error(error!))
            }
            let data = results ?? []
            let objects = data.map { self.init(record: $0) }

            let recordIds = objects.map { $0.author.recordID }
            let fetchOperation = CKFetchRecordsOperation(recordIDs: recordIds)
            fetchOperation.fetchRecordsCompletionBlock = { records, error in
                if error != nil {
                    return completion(.error(error!))
                }
                let authors = records ?? [:]
                
                objects.forEach { o in
                    let ao = authors[o.author.recordID]!
                    o.authorObject = AccountRecord(record: ao)
                }

                completion(.success(objects))
            }
            publicDatabase.addOperation(fetchOperation)
        }
    }

}