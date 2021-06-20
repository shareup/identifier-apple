import XCTest
import Identifier

final class IdentifierTests: XCTestCase {
    func testStringValueIsBase64() throws {
        // NOTE: "foo"
        let id = Identifier(rawValue: [102, 111, 111])
        XCTAssertEqual("Zm9v", id.base64URLEncodedString())
        
        let sameID = try Identifier(base64URLEncoded: "Zm9v")
        XCTAssertEqual([102, 111, 111], sameID.rawValue)
        
        XCTAssertEqual(id, sameID)
    }
    
    func testEmptyInitializer() throws {
        let identifier = Identifier()
        let sameIdentifier = Identifier(rawValue: identifier.rawValue)
        
        XCTAssertEqual(identifier, sameIdentifier)
    }
    
    func testCanInitializeFromUUID() throws {
        let uuid = UUID()
        let u = uuid.uuid
        let uuidBytes = [u.0, u.1, u.2, u.3, u.4, u.5, u.6, u.7, u.8, u.9, u.10, u.11, u.12, u.13, u.14, u.15]
        
        let identifier = Identifier(uuid: uuid)
        
        XCTAssertEqual(uuidBytes, identifier.rawValue)
    }
}
