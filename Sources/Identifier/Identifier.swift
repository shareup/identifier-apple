import Foundation

public struct Identifier:
    Codable, CustomStringConvertible, ExpressibleByStringLiteral,
    Hashable, RawRepresentable
{
    public let rawValue: [UInt8]
    public let stringValue: String
    
    public var description: String { stringValue }
    public var ns_string: NSString { stringValue as NSString }

    public init(rawValue: [UInt8]) {
        self.rawValue = rawValue
        self.stringValue = rawValue.map {
            String($0, radix: 16).padding(toLength: 2, withPad: "0", startingAt: 0)
        }.joined()
    }
    
    public init() {
        self.init(ofSize: 16)
    }
    
    public init(ofSize count: Int) {
        var bytes = [UInt8](repeating: 0, count: count)
        
        if SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes) != errSecSuccess {
            fatalError("Cannot generate random bytes so we are dead...")
        }
        
        self.init(rawValue: bytes)
    }

    public init(data: Data) {
        self.init(rawValue: [UInt8](data))
    }
    
    public init(string: String) {
        if string.count % 2 == 0 && string.allSatisfy({ $0.isHexDigit }) {
            let bytes = stride(from: 0, to: string.count, by: 2).map { i -> UInt8 in
                let startIndex = string.index(string.startIndex, offsetBy: i)
                let endIndex = string.index(string.startIndex, offsetBy: i + 1)
                return UInt8(string[startIndex ... endIndex], radix: 16)!
            }
            
            self.init(rawValue: bytes)
        } else {
            self.init(rawValue: [UInt8](string.utf8))
        }
    }

    public init(stringLiteral value: String) {
        self.init(string: value)
    }
    
    public init(uuid: UUID) {
        let data = withUnsafePointer(to: uuid.uuid) {
            Data(bytes: $0, count: MemoryLayout.size(ofValue: uuid.uuid))
        }
        
        self.init(data: data)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self.init(string: value)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(stringValue)
    }
}
