# Protocols And Extensions Notes

## Topic Summary

This playground explores protocols as contracts, protocol-based polymorphism, type casting with protocol values, and default behavior added through protocol extensions.

## Questions For The Coding Assistant

### Question

Why can a protocol extension provide a default implementation, and when is that behavior dispatched statically or dynamically?

### Answer Summary
A protocol extension can provide a default implementation because Swift lets protocols define a contract, and extensions can say: “for any type that conforms to this protocol, here is shared behavior you get automatically.”

In your playground:
```swift
protocol Dog {
    var name: String { get set }
    var color: String { get set }
}

extension Dog {
    func bark() {
        print("Woof! ")
    }
}
```

Every Dog gets bark() even though bark() is not written inside the protocol itself.

The important dispatch rule is this:

If the method is a protocol requirement, dispatch is dynamic through the protocol witness table.

Example:
```swift
protocol Dog {
    var name: String { get set }
    var color: String { get set }

    func bark()
}

extension Dog {
    func bark() {
        print("Woof!")
    }
}

struct Mutt: Dog {
    var name: String
    var color: String

    func bark() {
        print("Woof woof!")
    }
}

let dog: any Dog = Mutt(name: "Buddy", color: "Brown")
dog.bark() // "Woof woof!"
```

Because bark() is part of the protocol requirement, Swift dynamically dispatches to Mutt’s implementation.

But in your current code, bark() is only in the extension, not in the protocol:

```swift
protocol Dog {
    var name: String { get set }
    var color: String { get set }
}

extension Dog {
    func bark() {
        print("Woof!")
    }
}
```
That means bark() is statically dispatched when the value is viewed as Dog.

So this:
```swift
let maple = Mutt(name: "Buddy", color: "Brown")
maple.bark()
```

calls Mutt.bark() because maple is known to be a Mutt.

But this:
```swift
let dog: any Dog = Mutt(name: "Buddy", color: "Brown")
dog.bark()
```
calls the protocol extension’s bark(), not Mutt.bark(), because bark() is not a protocol requirement.

Rule of thumb:
```swift
// Dynamic dispatch
protocol Dog {
    func bark()
}

// Static dispatch
extension Dog {
    func bark() { }
}
```
So if you want conforming types to be able to override behavior polymorphically, put the method in the protocol declaration and provide the default implementation in the extension.

### Question

What's the purpose of the keyword any in lowercase in this Playground?

### Answer Summary

In this playground, lowercase any means “an existential value”: a value whose concrete type is hidden, but which is guaranteed to conform to a protocol.

Here:

```swift
let mixed2: [any Dog] = [
    JackRussel(name: "Dash", color: "Brown and White"),
    WhiteLab(name: "Lily", color: "White")
]
```

mixed2 is an array that can hold different concrete types, as long as each one conforms to Dog. So it can contain both a JackRussel struct and a WhiteLab class.

The difference from uppercase Any is:

```swift
let mixed: [Any] = [42, "Hi", true]
```

So, lowercase any is Swift’s explicit way of saying: “I want to store a protocol value, not a specific concrete type.”

### Keep In Mind

- "any" keyword may be optional in some contexts for compatibility, but any Dog is the modern, explicit spelling and is better to use when you mean a protocol existential.

## Experiments Tried

- Add a new type conforming to `Person`.
- Add a new requirement to `Dog` and update the conforming types.
- Compare custom implementations versus extension defaults.
