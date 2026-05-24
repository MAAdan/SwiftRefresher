import UIKit

var greeting = "Hello, playground"

let closure1 = { () -> Void in
    print("Hello world!")
}

closure1()

let closure2 = { (name: String) -> Void in
    print("Hello " + name)
}

closure2("Miguel")

func testClosure(handler: (String) -> Void) {
    handler("Angel")
}

testClosure(handler: closure2)

let closure3 = { (name: String) -> String in
    "Hello \(name)"
}

var message = closure3("Adan")
print(message)

func testFunction(num: Int, handler: () -> Void) {
    for _ in 0..<num {
        handler()
    }
}

testFunction(num: 5, handler: closure1)

// Trailing closure syntax
func testFunction2(num: Int, handler: (_: String) -> Void) {
    for _ in 0..<num {
        handler("Me")
    }
}

testFunction2(num: 5) { name in
    print(closure3(name))
}

let guests = ["Miguel", "Angel", "Adan", "Roman"]

guests.map { name in
    print("Hello \(name)")
}

print("---")
guests.map{ print("Hello \($0)") }

func analyseTemperatures(analysis: ([Int]) -> Void) {
    let tempArray = [72, 74, 76, 68, 70, 72, 66]
    analysis(tempArray)
}

let threshold = 71

let daysAboveTemperature = { (temperatures: [Int]) in
    var aboveThresholdCount = 0
    for temp in temperatures {
        if temp > threshold {
            aboveThresholdCount += 1
        }
    }

    print("Number of days above \(threshold): \(aboveThresholdCount)")
}

analyseTemperatures( analysis: daysAboveTemperature )


enum LogLevel {
    case info, warning, error
}

class Logger {
    typealias logLevelHandler = (String) -> Void

    private var handlers: [LogLevel: [logLevelHandler]] = [:]

    func registerHandler(for level: LogLevel, handler: @escaping logLevelHandler) {
        if handlers[level] == nil {
            handlers[level] = []
        }

        handlers[level]?.append(handler)
    }

    func log(_ message: String, level: LogLevel) {
        if let levelHandlers = handlers[level] {
            for handler in levelHandlers {
                handler(message)
            }
        }
    }
}

let logger = Logger()

logger.registerHandler(for: .info) { msg in
    print("INFO: \(msg)")
}

logger.registerHandler(for: .warning) { msg in
    print("WARNING: \(msg)")
}

logger.registerHandler(for: .error) { msg in
    print("ERROR: \(msg)")
}

let emailError = { (message: String) -> Void in
    print("Emailed Error: \(message)")

}

logger.registerHandler(for: .error) { (msg: String) -> Void in
    print("Emailed Error: \(msg)")
}

logger.log("Informational Message", level: .info)
logger.log("Warning message", level: .warning)
logger.log("We have an error", level: .error)


//Result builders

@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> String {
        return components.joined()
    }
}

func buildString(@StringBuilder _ components: () -> String) -> String {
    return components()
}

let result = buildString {
    "Hello, "
    "Miguel "
    "Angel "
    "Adan "
}

print(result)

//Create a Result Builder that takes a JSON and put it into a dictionary
struct DictionaryComponent {
    let dictionary: [String: Any]

    func addToJson(_ json: inout [String: Any]){
        for (key, value) in dictionary {
            json[key] = value
        }
    }
}

@resultBuilder
struct JSONBuilder {
    static func buildBlock(_ components: DictionaryComponent...) -> [String: Any] {
        var json: [String: Any] = [:]
        components.forEach { $0.addToJson(&json) }
        return json
    }

    static func buildExpression(_ expression: [String: Any]) -> DictionaryComponent {
        return DictionaryComponent(dictionary: expression)
    }
}

@JSONBuilder
func buildJSON() -> [String: Any]{
    [
        "name": "Jon",
        "age": 30,
        "address": [
            "city": "Boston",
            "zipcode": "10001"
        ]
    ]
}

let json = buildJSON()
print(json)

