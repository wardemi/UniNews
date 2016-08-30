//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


/*:
 ### Opcionális érték, mint hiba
 
 Probléma: elfedi a hibát.
 */

let maybeError: String? = nil


func contentsOf1(file filename: String) -> String? {
    return nil
}

if let content1 = contentsOf1(file: "example.txt") {
    //ok we have some content... but where is my error?
}

/*:
 ### A hiba típusa
 
 Ha elfedjük a hibát, akkor nem láthatjuk az okát.

 */

enum FileError: ErrorType {
    
    case notFound(String)
    case permissionDenied
    case unknownFormat
    
}

extension FileError: CustomStringConvertible {
    var description: String {
        switch self {
        case .notFound(let filename):
            return "Unable to find file \(filename)."
        case .permissionDenied:
            return "You do not have permission to access the file."
        case .unknownFormat:
            return "Unable to open file incompatible format."
        }
    }
}

/*:
 ### do-try-catch
 
 Nem teljes értékű exception! Csak NSError syntax sugar.
 
 Probléma: nem működik aszinkron hívásokkal.
 */

func contentsOf2(file filename: String) throws -> String {
    throw FileError.unknownFormat
}


do {
    let content2 = try contentsOf2(file: "example.txt")
}
catch let error as FileError {
    print(error)
}
catch {
    print(error)
}

/*:
 ### Async throw
 
 Nem a legjobb megoldás...
 */

func asyncOperation1(operation:() throws -> String, completion: (() throws -> String) -> Void) -> Void {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        
        var result: () throws -> String
        do {
            let output = try operation()
            result = { output }
        }
        catch {
            result = { throw error }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            completion(result)
        }
    }
}

asyncOperation1({ () -> String in try contentsOf2(file: "example.com") }) { result in
    do {
        let value = try result()
        print(value)
    }
    catch {
        print(error)
    }
}

/*:
 ### Rethrow
 
 Ha egy függvény paramétere hibát dobhat akkor tovább dobhatjuk azt...
 */

func log(method: Void throws -> String) rethrows -> Void {
    print(try method())
}


try? log { Void -> String in
    return try contentsOf2(file: "example.txt")
}



/*:
 ### Result típus
 
 Best practice.
 */


enum Result<T> {
    case failure(ErrorType)
    case success(T)
}

func contentsOf3(file filename: String) -> Result<String> {
    return Result.failure(FileError.notFound(filename))
}

let content3 = contentsOf3(file: "example.txt")


switch content3 {
case let .success(content):
    print(content)
case let .failure(error):
    print(error)
}

/*:
 ### Async result
 
Ez már egy fokkal jobb, mint az async throw
 */

func asyncOperation2(operation: () throws -> String, completion:(Result<String>) -> Void) -> Void {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

        var result: Result<String>
        do {
            let output = try operation()
            result = .success(output)
        }
        catch {
            result = .failure(error)
        }

        dispatch_async(dispatch_get_main_queue()) {
            completion(result)
        }
    }
}


asyncOperation2({ () -> String in try contentsOf2(file: "example.com") }) { result in

    switch result {
    case let .success(content):
        print(content)
    case let .failure(error):
        print(error)
    }
}


/*:
 ###  További műveletek az eredménnyel
 
 Beolvastuk a fájlt, jó lenne feldolgozni is...
 */

extension Result {

    func map<U>(f: T -> U) -> Result<U> {
        switch self {
        case .success(let t):
            return .success(f(t))
        case .failure(let err):
            return .failure(err)
        }
    }

    func flatMap<U>(f: T -> Result<U>) -> Result<U> {
        switch self {
        case .success(let t):
            return f(t)
        case .failure(let err):
            return .failure(err)
        }
    }
}


func asyncOperation3<T>(operation: () throws -> T, completion:(Result<T>) -> Void) -> Void {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        
        var result: Result<T>
        do {
            let output = try operation()
            result = .success(output)
        }
        catch {
            result = .failure(error)
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            completion(result)
        }
    }
}

asyncOperation3({ try contentsOf2(file: "example.com") }) { result in
    
    let newResult = result
                        .map { $0.characters.count }
                        .map { $0 > 100 }
    
    switch newResult {
    case .success(let value):
        print(value)
    case .failure(let error):
        print(error)
    }
}


/*:
 ###  Egyszerűbben is lehet...
 
 
 */

extension Result {
    
    func resolve() throws -> T {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    init(@noescape _ block: Void throws -> T) {
        do {
            let value = try block()
            self = .success(value)
        }
        catch {
            self = .failure(error)
        }
    }
}


let result = Result { try contentsOf2(file: "example.com") }
                .map { $0.characters.count }
                .map { $0 > 100 }

do {
    let content = try result.resolve()
    print(content)
}
catch {
    print(error)
}



//XCPlaygroundPage.currentPage.finishExecution()



/*:
 ### További olvasmányok
 
 - [link](https://theswiftdev.com/2016/08/11/all-about-errors-functors-monads-and-promises/)
 
 */

