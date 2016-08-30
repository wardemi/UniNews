import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: ## NSURLSession
//: It's technically both a class and a suite of classes for handling HTTP/HTTPS based requests
//: ### We can create via NSURLSessionConfiguration, which has three type
//: * defaultSessionConfiguration - it uses the disk-persisted global cache, credential and cookie storage objects
//: * ephemeralSessionConfiguration - similar for defaultSessionConfiguration, just session releated data is stored in memory / like a **private** session
//: * backgroundSessionConfiguration - upload and download tasks in background
//: It also allows to configure timeout; additional headers; caching policies
//: ### NSURLSessionTask
//: A session creates a task which does the actual work
//: * NSURLSessionDataTask - for GET requests, retreive data from servers to memory
//: * NSURLSessionUploadTask - for file upload PUT POST
//: * NSURLSessionDownloadTask - download
//: ### NSURLProtocol
//: It handles the loading of protocol-specific URL data. It lets you redefine how Apple's URL Loading System operates, by defining custom URL schemes and redefining the behavior of existing URL schemes. It's useful eg.: monitoring the network flow.
let request = NSMutableURLRequest(URL: NSURL(string: "https://httpbin.org/get")!)

let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
    if let error = error {
        print(error)
        return
    }

    let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
    print(result)
}
task.resume()


//: ## Alamofire
//: [Alamofire](https://github.com/Alamofire/Alamofire)
//: Elegant HTTP Networking in Swift

import Alamofire


Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
    .responseJSON { response in
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
            print("JSON: \(JSON)")
        }
        
        //XCPlaygroundPage.currentPage.finishExecution()
}

//: [Previous](@previous)
