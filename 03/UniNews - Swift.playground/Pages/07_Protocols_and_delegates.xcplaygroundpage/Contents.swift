/*:
 
 *A Swift programozási nyelv*
 
 ## Protokollok és delegálás
 
 -----
 
 */

/*:
 ### Protokollok és kiegészítések
 
 A protokoll nem más, mint egy interfész amit megvalósíthat egy másik típus.
 */

protocol AnimalProtocol
{
    var numberOfLegs: Int { get set }

    func move()
}



class AnimalClass: AnimalProtocol
{
    var numberOfLegs: Int
    
    init(legs: Int) {
        self.numberOfLegs = legs
    }
}

class DogClass: AnimalClass
{
    var name: String
    
    init(name: String, legs: Int = 4) {
        self.name = name
        super.init(legs: legs)
    }
}

extension AnimalProtocol
{
    func move() {
        print("I am moving now...")
    }
}


extension DogClass
{
    func move() {
        print("I am \(self.name) and I am moving on my \(self.numberOfLegs) now...")
    }
}

let charlieDog = DogClass(name: "Charlie")

charlieDog.name
charlieDog.move()


/*:
 ### Delegálás
 
 Egy tetszőleges feladat megvalósításának kiszervezése egy másik helyre (jellemzően osztályba)
 */


protocol DataSource
{
    func getNumbers() -> [Int]
}


class Organizer
{
    var delegate: DataSource
    
    init(delegate: DataSource) {
        self.delegate = delegate
    }
    
    func sum() -> Int {
        let numbers = self.delegate.getNumbers()

        return numbers.reduce(0, combine: +)
    }
}



class MyDataSourceController: DataSource
{
    func getNumbers() -> [Int] {
        return [1,2,3,4]
    }
}


var myOrganizer = Organizer(delegate: MyDataSourceController())
myOrganizer.sum()


/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


