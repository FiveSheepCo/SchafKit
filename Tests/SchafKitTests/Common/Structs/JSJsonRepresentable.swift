import Foundation

import SchafKit
#if !os(watchOS)
import XCTest

class SKJsonRepresentableTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNilValues() {
        let original = SKJsonRepresentable(object: nil)
        let original2 = SKJsonRepresentable(jsonRepresentation: nil as Data?)
        
        XCTAssertFalse(original.exists)
        XCTAssertFalse(original2.exists)
    }
    
    func testReversal() {
        let original = SKJsonRepresentable(object: ["Hey": "Ho", "Ho": 2, "Toast": ["Test"]])
        
        for rep in [original, SKJsonRepresentable(jsonRepresentation: original.jsonRepresentation), SKJsonRepresentable(jsonRepresentation : String(data: original.jsonRepresentation!, encoding: .utf8))]{
            XCTAssertNotNil(rep.jsonRepresentation)
            
            XCTAssertTrue(rep.exists)
            XCTAssertNil(rep.boolValue)
            
            XCTAssertEqual(rep["Hey"].stringValue, "Ho")
            XCTAssertNil(rep["Hey"].intValue)
            
            XCTAssertEqual(rep["Ho"].intValue, 2)
            XCTAssertEqual(rep["Ho"].doubleValue, 2.0)
            XCTAssertNil(rep["Ho"].stringValue)
            
            XCTAssertFalse(rep["Test"].exists)
            
            XCTAssertTrue(rep["Toast"].exists)
            XCTAssertTrue(rep["Toast"][0].exists)
            XCTAssertEqual(rep["Toast"][0].stringValue, "Test")
        }
    }
    
    func testNilability() {
        let originals = [SKJsonRepresentable(object: nil), SKJsonRepresentable(jsonRepresentation: nil as Data?), SKJsonRepresentable(jsonRepresentation: nil as String?)]
        
        for original in originals {
            XCTAssertNotNil(original[0])
            
            XCTAssertNil(original.jsonRepresentation)
        }
    }
    
    func testEditing() {
        let original = SKJsonRepresentable(object: ["a": "Ho", "b": 2, "c": ["c1": "Tests"]])
        
        original["a"] = SKJsonRepresentable(object: nil)
        original["c"] = SKJsonRepresentable(object: ["c1": nil])
        
        XCTAssertNil(original["a"].value)
        XCTAssertNil(original["c"]["c1"].value as? String)
    }
}
#endif
