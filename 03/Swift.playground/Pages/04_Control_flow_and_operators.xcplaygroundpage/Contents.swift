/*:
 
 *A Swift programozási nyelv*
 
 ## Utasítások és operátorok
 
 -----
 
 */

/*:
 ### Értékadás
 */

var a = 6
var b = 4
var c = 3

var isWeekend: Bool = false
var nilString: String? = nil

let names = ["Bob", "Joe", "Kevin"]

let airports = [
    "BUD": "Budapest",
    "LAX": "Los Angeles",
    "NYC": "New York",
]

/*:
 ### Operátorok
 
 * **Egy értékű** *(-a)*
 * **Kettő értékű**  *(a + 3)*
 * **Három értékű** *(a ? b : c)*
 
 */

-a              // a = -1 * a
+a              // a = +1 * a
!isWeekend      // "tagadás"

a + b           // összeadás
a - b           // kivonás
a * b           // szorzás
a / b           // osztás
a % b           // maradékos osztás

a == b          // egyenlőség vizsgálata
a != b          // nem egyenlő
a <= b          // kisebb vagy egyenlő
a >= b          // nagyobb vagy egyenlő
a < b           // kisebb
a > b           // nagyobb


a += b          // a = a + b
a -= b          // a = a - b
a *= b          // a = a * b
a /= b          // a = a / b


//ha hétvége akkor a, különben b
isWeekend ? a : b

//ha van értéke akkor az érték, különben a másik érték
nilString ?? "fallback"


1...10          //1,2,3,4,5,6,7,8,9,10
0..<100         //0...99

!true
true && false
true || false


/*:
 ### if-else
 
 Egyszerű feltételvizsgálat
 */


if a == 10 {
    print("a is exactly 10")
}
else if a > 10 {
    print("a is a big number")
}
else {
    print("a is a small number")
}

/*:
 ### switch-case
 
 Összetett feltételvizsgálat
 */

switch a {
case 0:
    print("a is zero")
case 1...10:
    print("a is a small number")
case 11..<100:
    print("a is a big number")
default:
    print("a is a very big number")
}


/*:
 ### if-let
 
 Opcionális érték nil vizsgálata
 
 */

if let myString = nilString {
    print(myString)
}


/*:
 ### guard-else
 
 Opcionális érték garantált nem nil értékké alakítása
 
 Az else ágban kötelező megszakítani az aktuális futást (return, break)
 */
_ = {
    guard let myString = nilString else {
        return
    }
    print(myString)
}()

/*:
 ### for-in
 
 Itárálás elemeken.
 */


for i in 0...10 {
    print(i)
}

for i in 0.stride(to: 10, by: 2) {
    print(i)
}

for name in names {
    print(name)
}

for (key, name) in names.enumerate() {
    print("\(key): \(name)")
}

for (key, value) in airports {
    print("\(key): \(value)")
}


/*:
 ### while-repeat
 
 Egyszerű ciklusok
 */


var i = 10
while i > 0 {
    i -= 2
    print(i)
}


//egyszer mindenképpen lefut
var j = 10
repeat {
    print(j)
    j -= 2
} while j > 0



/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


