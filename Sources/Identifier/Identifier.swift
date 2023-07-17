import Base64URL
import Foundation

public struct Identifier: Hashable, Sendable {
    private let storage: String

    public init(byteSize count: Int = 16) {
        var bytes = [UInt8](repeating: 0, count: count)

        if SecRandomCopyBytes(
            kSecRandomDefault,
            bytes.count,
            &bytes
        ) != errSecSuccess {
            fatalError("Cannot generate random bytes.")
        }

        self.init(data: Data(bytes))
    }

    public init(seed: String) {
        storage = Data(seed.utf8).base64URLEncodedString()
    }

    public init(data: Data) {
        storage = data.base64URLEncodedString()
    }

    public init(uuid: UUID) {
        let data = withUnsafePointer(to: uuid.uuid) {
            Data(bytes: $0, count: MemoryLayout.size(ofValue: uuid.uuid))
        }

        self.init(data: data)
    }

    public var data: Data {
        let data = Data([UInt8].init(storage.utf8))
        return Data(base64URLEncoded: data)!
    }
}

extension Identifier: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String { storage }
    public var debugDescription: String { description }
}

extension Identifier: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)

        guard let _ = Data(base64URLEncoded: string) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid Base64URL-encoded string"
            )
        }

        storage = string
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(storage)
    }
}

public extension Identifier {
    @available(
        *,
        deprecated,
        message: "Identifier now represents a Base64URL-encoded string directly"
    )
    init(base64URLEncoded string: String) throws {
        precondition(Data(base64URLEncoded: string) != nil)
        storage = string
    }

    @available(
        *,
        deprecated,
        message: "Identifier now represents a Base64URL-encoded string directly"
    )
    func base64URLEncodedString() -> String {
        storage
    }
}
