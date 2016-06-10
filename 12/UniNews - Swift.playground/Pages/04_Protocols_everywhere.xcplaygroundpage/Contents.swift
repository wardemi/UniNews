/*:
 
 *Legjobb megoldások*
 
 ## Protokollok mindenütt
 
 -----
 
 */



/*:
 
 ### Hasznos források

 * [WWDC](https://developer.apple.com/videos/play/wwdc2015/408/)
 * [Introducing POP](https://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2)
 * [Subclassing sucks](http://krakendev.io/blog/subclassing-can-suck-and-heres-why)
 * [POP UIKit](https://www.captechconsulting.com/blogs/ios-9-tutorial-series-protocol-oriented-programming-with-uikit)
 * [POP in Swift 2.0](https://www.natashatherobot.com/updated-protocol-oriented-mvvm-in-swift-2-0/)
 * [POP - a fairy tale](https://medium.com/swift-programming/protocol-oriented-programming-a3e192f6e8f2#.ayfjrgtph)
 * [Mixins and traits](http://matthijshollemans.com/2015/07/22/mixins-and-traits-in-swift-2/)
 * [Mixins over inheritance](http://alisoftware.github.io/swift/protocol/2015/11/08/mixins-over-inheritance/)
 
 */

/*:
 
 ### Alap implementáció
 
 */


//  http://alisoftware.github.io/swift/protocol/2015/11/08/mixins-over-inheritance/

protocol Flyer
{
    func fly() -> String
}

extension Flyer
{
    func fly() -> String {
        return "I believe I can flyyyyy ♬"
    }
}

class SuperMan: Flyer
{
    // we don't implement fly() there so we get the default implementation and hear Clark sing
}

class IronMan: Flyer
{
    func fly() -> String {
        return "I am Iron Man!"
    }
}

let clark = SuperMan()
clark.fly()

let tony = IronMan()
tony.fly()

/*:
 
 ### Alap implementáció
 
 */


/*:
 -----
 
 [Előző oldal](@previous) | [Következő oldal](@next) | UniNews @ [github](https://github.com/Canecom/UniNews)
 
 */


