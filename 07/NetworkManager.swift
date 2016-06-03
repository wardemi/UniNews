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

let baseUrl = "https://project-1222363933064116453.firebaseio.com/"

class NetworkManager: NSObject {
    
    //MARK: Variables
    private let alamofire: Alamofire.Manager
    private let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage()
    
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
        alamofire.request(.GET, baseUrl + "posts.json?print=pretty", parameters: nil, encoding: .URL, headers: nil)
        .responseJSON { [unowned self] response in
            var news: [News]? = self.handleResponse(response, parser: { newsDict -> [News] in
                var news = [News]()
                for (_, value) in newsDict {
                    if let newsItemDict = value as? Dictionary<String, AnyObject> {
                        if let newsItem = self.dictToNews(newsItemDict) {
                            news.append(newsItem)
                        }
                    }
                }
                return news
            })
        }
    }
    
    func getSingleNews(name: String) {
        alamofire.request(.GET, baseUrl + "posts/\(name).json?print=pretty", parameters: nil, encoding: .URL, headers: nil)
        .responseJSON { [unowned self] response in
            var news: News? = self.handleResponse(response, parser: { [unowned self] newsDict -> News in
                return self.dictToNews(newsDict)!
            })
        }
    }
    
    func postNews(news: News) {
        alamofire.request(.POST, baseUrl + "posts.json", parameters: newsToDict(news), encoding: .URL, headers: nil)
        .responseJSON { [unowned self] response in
            var name: PostNewsResponse? = self.handleResponse(response, parser: { responseDict -> PostNewsResponse in
                return PostNewsResponse(name: responseDict["name"] as! String)
            })
        }
    }
    
    func updateNews(news: News, name: String) {
        alamofire.request(.PATCH, baseUrl + "posts/\(name).json?", parameters: newsToDict(news), encoding: .URL, headers: nil)
        .responseJSON { response in
            var news: News? = self.handleResponse(response, parser: { [unowned self] newsDict -> News in
                return self.dictToNews(newsDict)!
            })
        }
    }
    
    //MARK: Private methods
    private func handleResponse<T>(response: Response<AnyObject, NSError>, parser: (Dictionary<String, AnyObject> -> T)) -> T? {
        var result: T?
        switch response.result {
        case .Success(let JSON):
            guard let json = JSON as? Dictionary<String, AnyObject> else { return nil }
            result = parser(json)
        case .Failure(let error):
            print(error)
            //TODO: handle error
        }
        return result
    }
    
    private func newsToDict(news: News?) -> Dictionary<String, AnyObject>? {
        guard let news = news else { return nil }
        var result = Dictionary<String, AnyObject>()
        if let id = news.id {
            result["id"] = id
        }
        if let body = news.body {
            result["body"] = body
        }
        if let image = news.image {
            result["image"] = image
        }
        if let title = news.title {
            result["title"] = title
        }
        if let entertainment = news.entertainment {
            result["entertainment"] = entertainment
        }
        if let url = news.url {
            result["url"] = url
        }
        if let position = news.position {
            result["position"] = position
        }
        if let uploader_user = news.uploader_user {
            result["uploader_user"] = uploader_user
        }
        return result
    }
    
    private func dictToNews(dict: Dictionary<String, AnyObject>?) -> News? {
        guard let dict = dict else { return nil }
        return News(id: dict["id"] as? String, body: dict["body"] as? String, image: dict["image"] as? String, title: dict["title"] as? String, entertainment: dict["entertainment"] as? String, url: dict["url"] as? String, position: dict["position"] as? [Int], uploader_user: dict["uploader_user"] as? String)
    }
    
}
