import XCTest
@testable import Identifier

final class IdentifierTests: XCTestCase {
    func testEmptyInitializerGeneratedUUID() throws {
        let identifier = Identifier()
        let uuid = try XCTUnwrap(UUID(uuidString: identifier.rawValue))
        XCTAssertEqual(uuid.uuidString, identifier.rawValue)
    }

    func testCanSerializeToAndFromJSON() throws {
        let identifier = Identifier()
        let encoded = try JSONEncoder().encode(identifier)

        let rawEncoded = try XCTUnwrap(String(data: encoded, encoding: .utf8))
        XCTAssertEqual("\"\(identifier.rawValue)\"", rawEncoded)

        let decoded = try JSONDecoder().decode(Identifier.self, from: encoded)
        XCTAssertEqual(identifier, decoded)
    }
}
