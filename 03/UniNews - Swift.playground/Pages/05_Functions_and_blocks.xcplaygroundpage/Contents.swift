/*:
 
 *A Swift programozási nyelv*
 
 ## Függvények és blokkok
 
 -----
 
 */

/*:
 ### Definíció és függvényhívás
 */

func helloWorld() {
    print("Hello world!")
}

helloWorld()

/*:
 ### Paraméterek és elnevezések
 */

func writeOut(something: String = "Hellow world") {
    print(something)
}

writeOut()
writeOut("Hi world!")


//Paraméter elnevezése
func writeOut(string something: String) {
    print(something)
}

writeOut(string: "Hello world!")


//Több paraméternév
func writeOut(string something: String, numberOfTimes: Int) {
    for _ in 0..<numberOfTimes {
        print(something)
    }
}

writeOut(string: "Hello world!", numberOfTimes: 3)


//Paraméternév elhagyása
func writeOut(string something: String, _ numberOfTimes: Int) {
    writeOut(string: something, numberOfTimes: numberOfTimes)
}

writeOut(string: "Hello world!", 3)


/*:
 ### Paraméter lista
 */

func sumInteger(numbers: Int...) -> Int {
    var total: Int = 0
    for number in numbers {
        total += number
    }
    return total
}

sumInteger(1,2,3,4,5)

/*:
 ### Paraméter referenciák
 */

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 10
var b = 20

swap(&a, &b)

a
b

/*:
 ### Visszatérési érték
 */

func sumIntegers(a: Int, _ b: Int) -> Int {
    return a + b
}

let c = sumIntegers(10, 12)



/*:
 ### Függvénytípusok
 
 Minden függvény leírható a következő képpen: (<paraméterek>) -> (<visszatérési érték>)
 
 */

var sumFunction: (Int, Int) -> Int

var firstVoidFunction: (Void) -> Void
var secondVoidFunction: () -> ()
var thirdVoidFunction: (Void) -> ()
var fourthVoidFunction: () -> Void
var fiftVoidFunction: Void -> Void


firstVoidFunction = {
    print("hello void function")
}

secondVoidFunction = firstVoidFunction
thirdVoidFunction = firstVoidFunction
fourthVoidFunction = firstVoidFunction
fiftVoidFunction = firstVoidFunction

fiftVoidFunction()



/*:
 ### Blokkok
 
 Név nélküli függvények
 
 ```
 { (<paraméterek>) -> <visszatérési érték> in
 
    //függvénytörzs
 
 }
 ```
 
 */


let myIntBlock: (Int) -> Int = { (x: Int) -> Int in
    print(x)
    return x
}

let aNumber = myIntBlock(6)



/*:
 ### Blokkok a gyakorlatban

 Tömb elemeinek a rendezése
 */


var fruits = ["banana", "kiwi", "apple", "orange", "mango"]

//blokk
fruits.sort({ (s1: String, s2: String) -> Bool in
    return s1 < s2
})


//egy soros blokk
fruits.sort( { (s1: String, s2: String) -> Bool in return s1 < s2 } )

//típus nélkül
fruits.sort( { s1, s2 in return s1 < s2 } )

//return elhagyással
fruits.sort( { s1, s2 in s1 < s2 } )

//rövid argumentum elnevezéssel
fruits.sort( { $0 < $1 } )

//operátor függvénnyel
fruits.sort(<)


/*:
 Ha egy függvény utolsó paramétere blokk, akkor
 */

fruits.sort { $0 < $1 }

fruits.sort { s1, s2 in
    s1 < s2
}



/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


