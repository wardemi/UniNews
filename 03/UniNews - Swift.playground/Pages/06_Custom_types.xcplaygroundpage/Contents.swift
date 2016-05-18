/*:
 
 *A Swift programozási nyelv*
 
 ## Egyedi típusok
 
 -----
 
 */

/*:
 ### Típus aliasok
 
 Bármilyen típust elnevezhetünk egy új névvel.
 */

typealias Number = Int
typealias VoidBlock = Void -> Void

let a: Number = 12

func somefunctionWithCompletion(block: VoidBlock) {
    print("hello")
    block()
}

somefunctionWithCompletion {
    print("world")
}


/*:
 ### Felsorolás típusok
 */

enum Direction
{
    case North
    case South
    case East
    case West
}

let compassDirection: Direction = .North


/*:
 ### Struktúrák
 */

struct Point
{
    var x: Int
    var y: Int
}


let firstPoint  = Point(x: 2, y: 4)
let secondPoint = Point(x: 4, y: 8)


/*:
 ### Osztályok
 */

class Animal
{
    var numberOfLegs: Int
    
    init(numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
    
    func sayHello() {
        print("Hello, I am an animal with \(self.numberOfLegs) legs.")
    }
}


let someAnimal = Animal(numberOfLegs: 2)

/*:
 ### Struktúra vs osztály
 */

//struktúra
var thirdPoint = firstPoint
thirdPoint.x = 20

firstPoint.x
thirdPoint.x

//osztály
let anotherAnimal = someAnimal
anotherAnimal.numberOfLegs = 3

someAnimal.numberOfLegs
anotherAnimal.numberOfLegs


/*:
 ### Osztályok öröklődése
 */


class Dog : Animal
{
    var name: String
    
    init(name: String, numberOfLegs: Int) {
        self.name = name
        
        super.init(numberOfLegs: numberOfLegs)
    }

    override func sayHello() {
        print("Hello, I am \(self.name) the dog, I have \(self.numberOfLegs) legs.")
    }
}

let charlieTheDog = Dog(name: "Charlie", numberOfLegs: 4)

charlieTheDog.sayHello()


/*:
 ### Kiegészítések
 
 Minden enum, struct, class típus kiegészíthető extra metódusokkal
 */
/*:
 enum
 */
extension Direction
{
    func translate() {
        switch self {
        case .North:
            print("Észak")
        case .South:
            print("Dél")
        case .East:
            print("Kelet")
        case .West:
            print("Nyugat")
        }
    }
}

compassDirection.translate()

/*:
 struct
 */


extension Point
{
    func log() {
        print("\(self.x) - \(self.y)")
    }
}

firstPoint.log()


/*:
 class
 */
extension Animal
{
    func move() {
        print("I am moving now...")
    }
}

someAnimal.move()
charlieTheDog.move()


/*:
 ### A probléma
 */


extension Dog
{
//    func move() {
//        print("I am a dog and I am moving now...")
//    }
}

/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


