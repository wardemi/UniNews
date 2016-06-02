//
//  NetworkManager.swift
//  UniNews
//
//  Created by Őri László on 23/05/16.
//  Copyright © 2016 Virgo Kft. All rights reserved.
//

import Foundation
import Alamofire
import Timberjack

class NetworkManager: NSObject {
    
    //MARK: Variables
    let alamofire: Alamofire.Manager
    let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    
    //MARK: Singleton
    static let sharedInstance = NetworkManager()
    
    private override init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var protocolClasses = configuration.protocolClasses! as [AnyClass]
        protocolClasses.insert(Timberjack.self, atIndex: 0)
        configuration.protocolClasses = protocolClasses
        configuration.HTTPCookieStorage = cookies
        alamofire = Manager(configuration: configuration)
    }
 
    //MARK: Internal methods
    func getNews() {
        let headers = [
            "X-Something": "Something",
            "X-Something-Else": "SomethingElse"
        ]
        let parameters = [
            "param1Key": "param1Value",
            "param2Key": 43
        ]
        alamofire.request(.GET, "", parameters: parameters, encoding: .URL, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .Success(let JSON):
                print(JSON)
                guard let json = JSON as? Dictionary<String, AnyObject> else { return }
                // print(json["valami"])
                break
            case .Failure(let error):
                print(error)
                break
            }
        }
    }
    
}