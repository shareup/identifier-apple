import Base64URL
import Bytes
import Foundation

public struct Identifier: ContiguousBytes, CustomStringConvertible, Equatable, Hashable, RawRepresentable {
    private let storage: Bytes

    public var rawValue: [UInt8] { storage.rawValue }
    public var data: Data { storage.data }
    public var description: String { base64URLEncodedString() }

    public init(rawValue: [UInt8]) {
        self.storage = Bytes(rawValue: rawValue)
    }
    
    public init(byteSize count: Int = 16) {
        self.storage = Bytes.random(size: count)
    }

    public init(data: Data) {
        self.storage = Bytes(data: data)
    }

    public init(uuid: UUID) {
        let data = withUnsafePointer(to: uuid.uuid) {
            Data(bytes: $0, count: MemoryLayout.size(ofValue: uuid.uuid))
        }
        
        self.init(data: data)
    }

    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
        try storage.withUnsafeBytes(body)
    }
}

extension Identifier {
    enum DecodingError: Error {
        case cannotDecodeBase64URL(String)
    }

    public init(base64URLEncoded string: String) throws {
        if let data = Data(base64URLEncoded: string) {
            self.init(data: data)
        } else {
            throw DecodingError.cannotDecodeBase64URL(string)
        }
    }

    public func base64URLEncodedString() -> String {
        Data(rawValue).base64URLEncodedString()
    }
}
