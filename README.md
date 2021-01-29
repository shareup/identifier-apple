# Identifier

`Identifier` is a `String`-backed, globally unique identifier. It is commonly used as a model identifier, and it supports Swift's `Identifiable` protocol.

## Usage

```swift
struct Todo: Hashable, Identifiable {
    let id: Identifier
    let title: String
    let isCompleted: Bool
}

extension Todo {
    init(title: String) {
        id = Identifier() // New, unqique identifier
        self.title = title
        isCompleted = false
    }
}
```

## Installation

### Swift Package Manager

To use SQLite with the Swift Package Manager, add a dependency to your Package.swift file:
 
 ```swift
 let package = Package(
    dependencies: [
        .package(
            name: "Identifier", 
            url: "https://github.com/shareup/identifier-apple.git", 
            from: "1.0.0"
        )
    ]
 )
```
