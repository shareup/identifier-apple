import Foundation

public struct Identifier:
    Codable, CustomStringConvertible, ExpressibleByStringLiteral,
    Hashable, RawRepresentable
{
    public let rawValue: String
    public var description: String { rawValue }
    public var ns_string: NSString { rawValue as NSString }

    public init() {
        rawValue = UUID().uuidString
    }

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        rawValue = value
    }
}
