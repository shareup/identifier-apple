import XCTest
import Identifier
import Base64URL

final class IdentifierTests: XCTestCase {
    func testStringValueIsBase64URLEncoded() throws {
        // NOTE: "foo"
        let id = Identifier(data: Data([102, 111, 111]))
        XCTAssertEqual("Zm9v", id.base64URLEncodedString())
        
        let sameID = try Identifier(base64URLEncoded: "Zm9v")
        XCTAssertEqual([102, 111, 111], [UInt8].init(sameID.data))
        
        XCTAssertEqual(id, sameID)
    }
    
    func testEmptyInitializer() throws {
        let identifier = Identifier()
        let sameIdentifier = Identifier(data: identifier.data)
        
        XCTAssertEqual(identifier, sameIdentifier)
    }
    
    func testInitializeFromUUID() throws {
        let uuid = UUID()
        let u = uuid.uuid
        let uuidBytes = [u.0, u.1, u.2, u.3, u.4, u.5, u.6, u.7, u.8, u.9, u.10, u.11, u.12, u.13, u.14, u.15]
        
        let identifier = Identifier(uuid: uuid)
        
        XCTAssertEqual(uuidBytes, [UInt8].init(identifier.data))
    }
    
    func testCodable() throws {
        struct Model: Codable, Hashable {
            let id: Identifier
        }
        
        let id = Identifier()
        let model = Model(id: id)
        
        let jsonData = try JSONEncoder().encode(model)
        let json = try XCTUnwrap(String(data: jsonData, encoding: .utf8))
        
        let expected = "{\"id\":\"\(id.description)\"}"
        XCTAssertEqual(expected, json)
        
        let decoded = try JSONDecoder().decode(Model.self, from: jsonData)
        XCTAssertEqual(model, decoded)
    }
}
