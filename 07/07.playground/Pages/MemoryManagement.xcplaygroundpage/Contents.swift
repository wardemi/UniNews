import Foundation

//: ## ARC
//: Automatic Reference Counting
//: Before ARC we had to **retain** and **release** the objects manually but now ARC cares of it automatically in compile time
//: ### Strong reference
//: It keeps a firm hold on the instance, and does not allow it to be deallocated for as long as that strong reference remains
//: ### Weak reference
//: It doesn't keep strong reference on the instance and allows to deallocate it, in this case ARC automatically sets the weak reference to nil. Because it could be nil, weak reference is always an optional
//: ### Unowned reference
//: Similar to weak reference but it always defined as a nonoptional type. It couldn't be nil.
//: ### Retain cycle
//: When two instance keep strong reference on each other

//: Example1:
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

//: Example2:
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {//[unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "Test", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

//: [Previous](@previous) <---> [Next](@next)
