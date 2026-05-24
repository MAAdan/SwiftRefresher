# ClosuresAndResultBuild

A small Swift playground project that explores two language features:

- Closures
- Result builders

The code is written as a hands-on learning playground rather than a packaged app or library. It includes simple examples you can run and modify in Xcode to understand how these features work.

## What's inside

The playground covers:

- Basic closure declarations and invocation
- Passing closures as function parameters
- Trailing closure syntax
- Using closures with collections such as `map`
- Capturing values from surrounding scope
- A simple `Logger` type that stores handlers by log level
- A custom `StringBuilder` result builder
- A custom `JSONBuilder` result builder that builds a dictionary

Main file:

- `ClosuresAndResultBuild.playground/Contents.swift`

## Requirements

- Xcode with Swift playground support
- Swift 6 playground runtime

The playground is configured for:

- Target platform: iOS
- Swift version: 6

## How to run

1. Open `ClosuresAndResultBuild.playground` in Xcode.
2. Run the playground.
3. Review the console output and edit the examples to experiment.

## Example topics demonstrated

### Closures

The playground includes examples of:

- Closures with no parameters and no return value
- Closures that accept parameters
- Closures that return values
- Passing named closures into functions
- Inline trailing closures

### Result builders

Two custom builders are included:

- `StringBuilder` joins multiple string components into one string
- `JSONBuilder` combines dictionary expressions into a single JSON-like dictionary

## Project structure

```text
ClosuresAndResultBuild/
├── ClosuresAndResultBuild.playground/
│   ├── Contents.swift
│   └── contents.xcplayground
└── README.md
```

## Notes

- This project is intended for learning and experimentation.
- The JSON example uses `[String: Any]` for simplicity.
- Output is printed directly from the playground.

## License

Examples from the book "Mastering Swift 6" by Jon Hoffman. All the examples from the book can be found publicly in the book's Github repository: https://github.com/PacktPublishing/Mastering-Swift-6-Seventh-Edition
