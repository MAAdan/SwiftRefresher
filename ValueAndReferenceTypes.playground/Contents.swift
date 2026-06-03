import UIKit

struct GradeValueType {
    var name: String
    var assignment: String
    var grade: Int
}

class GradeReferenceType {
    var name: String
    var assignment: String
    var grade: Int
    init(name: String, assignment: String, grade: Int) {
        self.name = name
        self.assignment = assignment
        self.grade = grade
    }
}

var ref = GradeReferenceType(name: "Bob", assignment: "Math", grade: 90)
var value = GradeValueType(name: "Bob", assignment: "Math", grade: 90)

func extraCreditReferenceType(ref: GradeReferenceType) {
    ref.grade += 10
}

// An inout parameter has a value that is passed into the function. This value is then modified by the function and is passed back out when the function exits to replace the original value.
func extraCreditValueType(value: inout GradeValueType) {
    value.grade += 10
}

func getGradeForAssignment(assignment: inout GradeValueType) {
    let num = Int.random(in: 80..<100)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

var mathGrades = [GradeValueType]()
let students = ["Jon", "Kelly", "Kai"]
var mathAssignment = GradeValueType(name: "", assignment: "Math Assignment", grade: 0)

for student in students {
    mathAssignment.name = student
    getGradeForAssignment(assignment: &mathAssignment)
    mathGrades.append(mathAssignment)
}

print("----")
for assignment in mathGrades {
    print("\(assignment.name): grade \(assignment.grade)")
}

//Noncopyable types. These noncopyable types enable us to create values with unique ownership and prevent instances from being copied.

struct Person: ~Copyable {
    var firstName: String
    var lastName: String
    var emailAddress: String
}


// Borrowing allows read-only access to a noncopyable value and does not transfer own-ership.
// Borrowing is useful when you need to inspect or use a value without consuming it.
// Borrowed values are thread-safe and can be accessed concurrently by multiple parts of your code.
func sendEmail(to: borrowing Person) {
    print("Sending email to \(to.firstName) \(to.lastName) at \(to.emailAddress)")
}

// Consuming transfers ownership of a noncopyable value, and the original variable be-comes invalid.
// Global instances of noncopyable types cannot be consumed.
// Consuming methods, such as the consumeUser() method, end the lifetime of the object when the method returns.
func consumeUser(_ user: consuming Person) {
    print("Consuming user")
}


func userFunction() {
    let user = Person(firstName: "Miguel", lastName: "Adan", emailAddress: "miguel@email.com")

    sendEmail(to: user)
    consumeUser(user)
}

// Noncopyable types can enhance performance in several key areas:
// By eliminating unnecessary copy of data, memory management becomes more efficient.
// The compiler can more accurately track an instance’s lifecycle.
// Resource leaks are reduced when, as examples, file descriptions, and network sockets are wrapped in non-copyable types, ensuring they cannot be accidentally duplicated.
//By enforcing unique ownership, noncopyable types can reduce locks in concurrent code.

// Recursive data types for reference types
// This is an object that contains values of the same type as a property of the type. These are used when we want to define dynamic data structures such as lists and trees.

class LinkedListRerecenceType {
    var value: String
    var next: LinkedListRerecenceType?
    init(value: String, next: LinkedListRerecenceType? = nil) {
        self.value = value
        self.next = next
    }
}

// In value types it is not possible to have Recursive data types because the value passed the value of the original object and not an instance

// Copy-on-write
fileprivate class BackendQueue<T> {
    private var items = [T]()
    public init() {}
    private init(items: [T]) {
        self.items = items
    }

    public func copy() -> BackendQueue<T> {
        return BackendQueue<T>(items: items)
    }

    public func add(_ item: T) {
        items.append(item)
    }

    public func getItem() -> T? {
        if items.count > 0 {
            return items.remove(at: 0)
        } else {
            return nil
        }
    }

    public func count() -> Int {
        return items.count
    }
}

struct Queue {
    private var internalQueue = BackendQueue<Int>()
    public mutating func addItem(item: Int){
        checkUniquelyReferencedInternalQueue()
        internalQueue.add(item)
    }
    public mutating func getItem() -> Int? {
        checkUniquelyReferencedInternalQueue()
        return internalQueue.getItem()
    }
    public func count() -> Int {
        return internalQueue.count()
    }
    private mutating func checkUniquelyReferencedInternalQueue() {
        if !isKnownUniquelyReferenced(&internalQueue) {
            internalQueue = internalQueue.copy()
            print("Making a copy of internalQueue")
        } else {
            print("Not making a copy of internalQueue")
        }
    }
    public mutating func uniquelyReferenced() -> Bool {
        return isKnownUniquelyReferenced(&internalQueue)
    }
}

var queue3 = Queue()
queue3.addItem(item: 1)
print(queue3.uniquelyReferenced())

var queue4 = queue3
print(queue3.uniquelyReferenced())
print(queue4.uniquelyReferenced())

queue3.addItem(item: 2)
