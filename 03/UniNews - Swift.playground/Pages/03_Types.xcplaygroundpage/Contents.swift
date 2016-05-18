/*:
 
 *A Swift programozási nyelv*
 
 ## Típusok
 
 -----
 
 */

/*:
 ## Egyszerű típusok
 
 * **String** - szöveges érték
 * **Int** - egész szám
 * **Float** - 32 bites lebegőpontos szám
 * **Double** - 64 bites lebegőpontos szám
 * **Bool** - igaz / hamis érték
 
 */

let a: String = "10"
let b: Int = 12
let c: Float = 13.5
let d: Double = 3.14
let e: Bool = true

/*:
 ## Összetett típusok
 
 * **Array** - Sorrendfüggő tömb
 * **Dictionary** - Kulcs-érték párosok
 * **Set** - Sorrendfüggetlen halmaz
 * **Tuple** - Két vagy több értékből alkotott összetétel
 */

var names: Array<String>
var numbers: Set<Int>
var airports: Dictionary<String, String>
var status: (code: Int, message: String)

status = (code: 500, message: "Internal server error")

names = ["Bob", "Joe", "Kevin"]

numbers = Set([1,3,5,7])

airports = [
    "BUD": "Budapest",
    "LAX": "Los Angeles",
    "NYC": "New York",
]


names[0]
numbers
numbers[numbers.startIndex]
airports["LAX"]
status.message


/*:
 ## Opcionálisok

 * A változónak van értéke és ez az érték egyenlő x-el.
 
 VAGY
 
 * A változónak nincs értéke (nil)
**/

var nameOrNil: String? = nil

nameOrNil = "Bob"

var intOrNil: Int? = 12

intOrNil = nil


/*:
 ## Típuskonverzió
 
 Adott típus másik típussá alakítása
 */

let intFromA = Int("10")

let f = 12 as Float     // Float
let g = "10" as? String // String?
let h = 10 as! Double   // Double (vagy crash)



/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


