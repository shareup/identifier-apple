# Identifier

`Identifier` is a `Bytes`-backed, globally unique identifier. It is commonly used as a model identifier and it can help one conform to Swift's `Identifiable` protocol.

## Usage

```swift
struct Todo: Hashable, Identifiable {
    let id: Identifier
    let title: String
    let isCompleted: Bool
}

extension Todo {
    init(title: String) {
        id = Identifier() // New, unique identifier
        self.title = title
        isCompleted = false
    }
}
```

## Installation

### Swift Package Manager

To use `Identifier` with the Swift Package Manager, add a dependency to your `Package.swift` file:
 
 ```swift
 let package = Package(
    dependencies: [
        .package(
            url: "https://github.com/shareup/identifier-apple.git", 
            from: "5.2.0"
        )
    ]
 )
```
