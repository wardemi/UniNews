# 4. AZ ARCHITEKTÚRA KIVÁLASZTÁSA

###Az előző ismétlése
- Építettünk layoutot vizuálisan
- A Swiftben is egészen otthon vagyunk

###Mi következik most?
- Foundation
- UIKit
- MVC
- Adatkötés
- Loggolás

###Foundation bemutatása
####Külső hivatkozások
- [The Foundation Framework](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/ObjC_classic/)
- [Swift foundation](https://github.com/apple/swift-corelibs-foundation)
- [Swift core libraries](https://swift.org/core-libraries/)
- [Swift Programming Fundamentals](https://youtu.be/e9oUykLjh4Y)
- [iOS From Scratch With Swift: Exploring the Foundation Framework](http://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-exploring-the-foundation-framework--cms-25155)

####Foundation
- Közös fw. az összes Apple OS-hez
- Még Objective-C-ben építették
- NS prefix mindenhol (NextStep)
- Alap classok és adatstruktúrákat foglal magában, mint NSObject, NSString, NSValue, NSNumber és még nagyon sok más
- NSObject nagyon fontos, ez minden alapja

###Néhány playground példa (inkább csak ismétlés)
```swift
import Foundation

//

var str = "Hello, playground"

//

class Book: NSObject {
    func chapters() {

    }

    func pages() {

    }
}

print(Book.classForCoder())
print(Book.superClass())

print(Book.conformsToProtocol(NSObjectProtocol.self))

print(Book.respondsToSelector("chapters"))

let book = Book()

print(book.respondsToSelector("chapters"))

//

let myNumber = NSNumber(double: 854416e+13)
print(myNumber.doubleValue)
print(myNumber.floatValue)
print(myNumber.intValue)

//

let stringA: NSString = "This is a string"
print(stringA.classForCoder)

//

let myArray = NSArray(objects: "Bread", "Butter", "Milk", "Eggs")
print(myArray.count)
print(myArray.objectAtIndex(2))

var myMutableArray = NSMutableArray(object: NSNumber(int: 265))
myMutableArray.addObject(NSNumber(int: 45))

//

let keyA: NSString = "myKey"
let keyB: NSString = "myKey"

let myDictionary = NSDictionary(object: "This is a string literal", forKey: keyA)

print(myDictionary.objectForKey(keyB))

//

let myMutableDictionary = NSMutableDictionary()
myMutableDictionary.setObject(myDictionary, forKey: "myDictionary")
```

###UIKit bemutatása
- A Foundation fölött helyezkedik el
- kifejezetten iOS app fejlesztéshez fejlesztették
- rengeteg osztály, adat típus, konstans, protokoll van itt
- import UIKit

###Ez alapján fogunk haladni lépésről lépésre
- [iOS From Scratch With Swift: First Steps With UIKit](http://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-first-steps-with-uikit--cms-25461)
- MVC pattern részletekbe menően
- https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/MVC-Process.svg/2000px-MVC-Process.svg.png
- [Delegate pattern](http://image.slidesharecdn.com/session4-141012070950-conversion-gate01/95/ios-development-using-swift-enums-arc-delegation-closures-table-view-and-more-14-638.jpg?cb=1413101355)
- Application Delegate
- ezekre külön kitérve: UIResponder, UIApplicationDelegate
- mi ez? és mire jó? UIWindow
- Storyboard
- Main.storyboard
- Project Navigator
- View Controller Scene
- Identity Inspector
- ViewController.swift
- UIViewController
- UIView
- Outlets
- Actions

###Hogyan illeszkedik ez a nagy appba?
- demo


###Alapvető logolási funkciók elsajátítása
- debugPrint és debugPrintln
- NSLog
- [Swift logging](http://ericasadun.com/2015/05/22/swift-logging/)
- [print vs NSLog](http://stackoverflow.com/questions/25951195/swift-print-vs-println-vs-nslog)
- [ez sokkal látványosabb](https://github.com/DaveWoodCom/XCGLogger)