# Protocols And Extensions Notes

## Topic Summary

This playground explores protocols as contracts, protocol-based polymorphism, type casting with protocol values, and default behavior added through protocol extensions.

## Questions For The Coding Assistant

### Question

What's the purpose of a subscript?

### Answer Summary
A subscript lets an instance be accessed with bracket syntax, like an array or dictionary:

```swift
myList[0]
myDictionary["key"]
```
A subscript lets an instance be accessed with bracket syntax, like an array or dictionary:

Example:
```swift
list.getItemAtIndex(index: 0)
```
you could define a subscript and write:

```swift
list[0]
```
Simple custom example:

```swift
struct Box {
    var items = ["A", "B", "C"]

    subscript(index: Int) -> String {
        items[index]
    }
}
```
So the short version is: a subscript makes your type usable with [], usually to expose element lookup in a cleaner way.


### Keep In Mind
* Generics allow us to tell a function or type "I know that Swift is a type-safe language, but I do not know the type that will be needed yet. I will give you a placeholder for now and will let you know what type to enforce later"
* The & symbol is used in conjuction with the inout parameter to pass the values as reference
* Type constraints. These specify that a generic type must inherit from a specific class or conform to a particular protocol. This allows us to use the methods or properties defined by the parent class or protocol within the generic function.
* Generic types. A generic type is a class that can contain any type, just like the arrays or dictionaries.
* It is possible to add extensions or functions conditionally to a generic type only if it conforms to a specific protocol using the "were T: Protocol" syntax


## Experiments Tried
* Type constraints
* Generic types
* Conditionally adding extensions with generics
* Conditionally adding functions to classes and protocols
* Conditional conformance
* Generic subscripts
* Associated types