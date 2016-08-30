import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//: ## NSOperation - NSOperationQueue
//: NSOperation - It's a task that we can run on background thread
//: NSOperationQueue - It's a queue where we should run the operations

//: ### State
//: ready -> executing -> finished

//: ### NSOperationQueuePriority
public enum NSOperationQueuePriority: Int {
    case VeryLow
    case Low
    case Normal
    case High
    case VeryHigh
}

//: ### NSQualityOfService
@available(iOS 8.0, OSX 10.10, *)
public enum NSQualityOfService : Int {
    case UserInteractive
    case UserInitiated
    case Utility
    case Background
    case Default
}

//: ### Example
let operation = NSOperation()
operation.queuePriority = .VeryLow
operation.qualityOfService = .Background

let operationQueue = NSOperationQueue()
operationQueue.addOperation(operation)

//: ### Dependencies; completionBlock
let operation1 = NSOperation()
operation1.completionBlock = {
    print("operation1")
}
let operation2 = NSOperation()
operation2.completionBlock = {
    print("operation2")
}
operation1.addDependency(operation2)

operationQueue.addOperations([operation1, operation2], waitUntilFinished: false)

//: ### NSBlockOperation
let blockOperation1 = NSBlockOperation.init { 
    print("blockOperation1")
}
let blockOperation2 = NSBlockOperation.init {
    print("blockOperation2")
}
blockOperation1.addDependency(blockOperation2)
operationQueue.addOperations([blockOperation1, blockOperation2], waitUntilFinished: false)

//: ### Run on Main Thread
let inOperationQueue = NSBlockOperation.init {
    print("inOperationQueue")
}
let inMainQueue = NSBlockOperation.init {
    print("inMainQueue")
}
inMainQueue.addDependency(inOperationQueue)
operationQueue.addOperation(inOperationQueue)
NSOperationQueue.mainQueue().addOperation(inMainQueue)

//: ## GCD - Grand Central Dispatch
//: It's a C-based API that makes easy to perform asynchronous operations
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { 
    print("Perform long running process")
    dispatch_async(dispatch_get_main_queue(), { 
        print("Update UI")
        XCPlaygroundPage.currentPage.finishExecution()
    })
}

//: [Previous](@previous) <---> [Next](@next)
