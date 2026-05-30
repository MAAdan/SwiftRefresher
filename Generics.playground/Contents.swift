import UIKit

// Generics allow us to tell a function or type, “I know Swift is a type-safe language, but I do not know the type that will be needed yet. I will give you a placeholder for now and will let you know what type to enforce later.”

//Example of functions that swap the values of two variables
func swapInts(a: inout Int,b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}

func swapDoubles(a: inout Double,b: inout Double) {
    let tmp = a
    a = b
    b = tmp
}

func swapStrings(a: inout String, b: inout String) {
    let tmp = a
    a = b
    b = tmp
}

var a = 5
var b = 10
swapInts(a: &a, b: &b)

print("a:\(a) b:\(b)")

//The & symbol is used in conjunction with the inout parameter to pass the values as reference

//Defining a generic function
func swapGeneric<T>(a: inout T, b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

swapGeneric(a: &a, b: &b)
print("a:\(a) b:\(b)")

var c = "My String 1"
var d = "My String 2"
swapGeneric(a: &c, b: &d)

print("c:\(c) d:\(d)")

//Type constraints
//These specify that a generic type must inherit from a specific class or conform to a particular protocol. This allows us to use the methods or properties defined by the parent class or protocol within the generic function.

func testGenericComparable<T: Comparable>(a: T, b: T) -> Bool {
    return a == b
}

class MyClass { }
protocol MyProtocol { }

//In this function, the type defined by the T placeholder must inherit from the MyClass class, and the type defined by the E placeholder must conform to the MyProtocol protocol
func testFunction<T: MyClass, E: MyProtocol>(a: T, b: E) {
    //Statements
}

//Generic types
//A generic type is a class or structure that can contain any type, just like arrays and dictionaries, e.g.
class List<T: Comparable> {
    private var items = [T]()

    func add(item: T) {
        items.append(item)
    }

    func getItemAtIndex(index: Int) -> T? {
        if items.count>index {
            return items[index]
        } else {
            return nil
        }
    }
}

var list = List<String>()
list.add(item: "Hello")
list.add(item: "World")
print(list.getItemAtIndex(index: 1)!)

var customList = List<Int>()

//Conditionally adding extensions with generics
//The following extension add the sum function to the generic type only if it conforms to the Numeric protocol
extension List where T: Numeric {
    func sum() -> T {
        return items.reduce(0, +)
    }
}

var list2 = List<Int>()
list2.add(item: 2)
list2.add(item: 4)
list2.add(item: 6)
print(list2.sum())

//Conditionally adding functions. Recommended over conditionally adding extensions as in the previous example.
extension List {
    func sum2() -> T where T: Numeric {
        return items.reduce(0, +)
    }

    func sorted() -> [T] where T: Comparable {
        return items.sorted()
    }
}

//Conditional conformance. It allows a generic type to conform to a protocol only if the type meets certain conditions.
extension List: Equatable where T: Equatable {
    static func == (lhs: List<T>, rhs: List<T>) -> Bool {
        if lhs.items != rhs.items {
            return false
        }

        for (e1, e2) in zip(lhs.items, rhs.items) {
            if e1 != e2 {
                return false
            }
        }
        return true
    }
}

//Generic subscripts
struct HashProvider {
    subscript<T: Hashable>(item: T) -> Int {
        return item.hashValue
    }
}

//Associated types. An associated type declares a placeholder name that can be used instead of a concrete type within a protocol where the type to use is not specified until the protocol is adopted.
protocol QueueProtocol {
    associatedtype QueueType
    mutating func add(item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

class IntQueue: QueueProtocol {
    typealias QueueType = Int

    var items = [Int]()

    func add(item: Int) {
        items.append(item)
    }

    func getItem() -> Int? {
        return items.count > 0 ? items.removeFirst() : nil
    }

    func count() -> Int {
        return items.count
    }
}

var intQ = IntQueue()
intQ.add(item: 2)
intQ.add(item: 4)

print(intQ.getItem()!)
intQ.add(item: 6)

//We can also implement Queue with a generic type. Let’s see how we would do this:
class GenericQueue<T>: QueueProtocol {
    var items = [T]()
    func add(item: T) {
        items.append(item)
    }
    func getItem() -> T? {
        return items.count > 0 ? items.remove(at:0) : nil
    }
    func count() -> Int {
        return items.count
    }
}

var stringQueue = GenericQueue<String>()
stringQueue.add(item: "Hi")
stringQueue.add(item: "Miguel")
print(stringQueue.getItem()!)
stringQueue.add(item: "Adan")

//Implicitly opened existentials. Before Swift 5.7, it was not possible to use protocols that contained associated types or self requirements as types.

protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() {
        print("Drawing a circle")
    }
}

struct Square: Drawable {
    func draw() {
        print("Drawing a square")
    }
}

// Before Swift 5.7, the following function would not be valid. Now, with the addition of the existential any, we can write this code like this:
func drawAll(_ items: [any Drawable]) {
    for item in items {
        item.draw()
    }
}
