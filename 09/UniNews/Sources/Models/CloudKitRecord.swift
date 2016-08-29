//
//  CloudKitRecord.swift
//  UniNews
//
//  Created by Canecom on 10/08/16.
//  Copyright © 2016 Canecom. All rights reserved.
//

import Foundation
import CloudKit


enum CloudKitResult<T> {
    case success(T)
    case error(ErrorType)

}

enum CloudKitError: ErrorType
{
    case noRecord
}


protocol CloudKitRecord
{
    static var recordName: String { get }
    
    var record: CKRecord { get }
    
    init(record: CKRecord)
}


extension CloudKitRecord
{
    var isAvailable: Bool {
        if let _ = NSFileManager.defaultManager().ubiquityIdentityToken {
            return true
        }
        return false
    }
}

extension CloudKitRecord
{

    static func fetchAll(completion: (CloudKitResult<[Self]>) -> Void) {
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
            completion(.success(objects))
        }
    }
    
    
    func save(completion: (CloudKitResult<Self>) -> Void) {
        self.record.save { result in
            switch result {
            case .success(let item):
                completion(.success(self.dynamicType.init(record: item)))
            case .error(let error):
                completion(.error(error))
            }
        }
    }

}


extension CKRecord {

    func fetchLatest(completion: (CloudKitResult<CKRecord>) -> Void) {
        let defaultContainer = CKContainer.defaultContainer()
        let publicDatabase = defaultContainer.publicCloudDatabase
        
        publicDatabase.fetchRecordWithID(self.recordID) { record, error in
            if error != nil {
                return completion(.error(error!))
            }
            if record == nil {
                return completion(.error(CloudKitError.noRecord))
            }
            completion(.success(record!))
        }
        
    }

    func save(completion: (CloudKitResult<CKRecord>) -> Void) {
        let defaultContainer = CKContainer.defaultContainer()
        let publicDatabase = defaultContainer.publicCloudDatabase
        
        publicDatabase.saveRecord(self) { record, error in
            if error != nil {
                return completion(.error(error!))
            }
            if record == nil {
                return completion(.error(CloudKitError.noRecord))
            }
            completion(.success(record!))
        }
    }
}