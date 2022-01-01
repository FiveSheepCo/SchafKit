import SchafKit
#if !os(watchOS)
import XCTest

class SK8BitRGBARepresentationTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReversal() {
        let rep = UIColor.white.bitRGBARepresentation
        XCTAssertEqual(rep.color.bitRGBARepresentation, rep)
    }
    
    func testPrecisionConversion() {
        let rep = SK8BitRGBARepresentation(representation : SKRGBARepresentation(red: 1, green: 1, blue: 1))
        XCTAssertEqual(rep.red, 255)
        XCTAssertEqual(rep.green, 255)
        XCTAssertEqual(rep.blue, 255)
        XCTAssertEqual(rep.alpha, 255)
    }
}
#endif
