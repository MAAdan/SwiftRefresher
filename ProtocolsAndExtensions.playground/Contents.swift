import UIKit

//Protocols as types
protocol Person {
    var firstName: String { get set }
    var lastName: String { get set }
    var birthDate: Date { get set }
    var profession: String { get set }

    init(firstName: String, lastName: String, birthDate: Date)
}

struct SwiftProgrammer: Person {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String

    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.profession = "Swift Programmer"
    }
}

struct FootballPlayer: Person {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.profession = "Football Player"
    }
}

var myPerson: Person
myPerson = SwiftProgrammer(firstName: "Miguel", lastName: "Adan", birthDate: Date())
print(myPerson)

myPerson = FootballPlayer(firstName: "Cristiano", lastName: "Ronaldo", birthDate: Date())
print(myPerson)

//Polymorphism with protocols
//Polymorphism gives us the ability to interact with various types with a standard interface.
var people: [Person] = []
people.append(SwiftProgrammer(firstName: "Miguel", lastName: "Adan", birthDate: Date()))
people.append(FootballPlayer(firstName: "Cristiano", lastName: "Ronaldo", birthDate: Date()))

for person in people {
    print("\(person.firstName) \(person.lastName): \(person.profession)")
}

//Typecasting with protocols
//Typecasting is a way to check the type of the instance and/or to treat the instance as a specific type.
for person in people {
    if person is SwiftProgrammer {
        print("\(person.firstName) \(person.lastName): \(person.profession)")
    }
}

for person in people {
    if let p = person as? FootballPlayer {
        print("\(person.firstName) \(person.lastName): \(person.profession)")
    }
}

for person in people {
    switch person {
    case is SwiftProgrammer:
        print("\(person.firstName) is a Swift Programmer")
    case is FootballPlayer:
        print("\(person.firstName) is a Football Player")
    default:
        print("\(person.firstName) is an unknown type")
    }
}

for person in people where person is SwiftProgrammer {
    print("\(person.firstName) is a Swift Programmer")
}

//Using protocols with enumerations
protocol Describable {
    var description: String { get }
}

enum VehicleType: Describable {
    case car, motorcycle, bus
    
    var description: String {
        switch self {
            case .car:
            return "Vehicle with 4 wheels"
        case .motorcycle:
            return "Vehicle with 2 wheels"
        case .bus:
            return "Big vehicle with 4 wheels"
        }
    }
}

//Protocol extensions
protocol Dog {
    var name: String { get set }
    var color: String { get set }
}

extension Dog {
    func bark() {
        print("Woof! ")
    }
}

struct JackRussel: Dog {
    var name: String
    var color: String
}

class WhiteLab: Dog {
    var name: String
    var color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
}

struct Mutt: Dog {
    var name: String
    var color: String

    func bark() {
        print("Woof woof!")
    }
}

let dash = JackRussel(name: "Dash", color: "Brown and White")
let lily = WhiteLab(name: "Lily", color: "White")
let maple = Mutt(name: "Buddy", color: "Brown")

dash.bark()
lily.bark()
maple.bark()

//Any and any
//Uppercase “Any”. The uppercase Any in Swift is a special type that can represent an instance of any type, including value types, reference types, and even optional types.

let mixed: [Any] = [42, "Hi", true]

//Existential “any”
//Existential types in Swift allow you to store any value that conforms to a specific protocol within a container.
let mixed2: [any Dog] = [
    JackRussel(name: "Dash", color: "Brown and White"),
    WhiteLab(name: "Lily", color: "White")
]

//Adopting protocols using a synthesized implementation
struct Name: Equatable {
    var firstName: String
    var lastName: String
}

let name1 = Name(firstName: "Miguel", lastName: "Adan")
let name2 = Name(firstName: "M.", lastName: "Adan")
let name3 = Name(firstName: "Miguel", lastName: "Adan")

print(name1 == name2)
print(name1 == name3)
