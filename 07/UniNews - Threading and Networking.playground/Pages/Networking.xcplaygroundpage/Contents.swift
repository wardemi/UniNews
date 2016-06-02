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
func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request) {(data, response, error) in
        if error != nil {
            callback("", error!.localizedDescription)
        } else {
            let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
            callback(result as String, nil)
        }
    }
    task.resume()
}
var request = NSMutableURLRequest(URL: NSURL(string: "http://www.google.com")!)
httpGet(request) {(data, error) in
if error != nil {
    print(error)
} else {
    print(data)
}
}

//: ## Alamofire
//: [Alamofire](https://github.com/Alamofire/Alamofire)
//: Elegant HTTP Networking in Swift

//: [Previous](@previous)
