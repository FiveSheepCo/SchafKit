import SchafKit
#if !os(watchOS)
import XCTest

class SKRGBARepresentationTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReversal() {
        let rep = UIColor.white.rgbaRepresentation
        XCTAssertEqual(rep.color.rgbaRepresentation, rep)
    }
}
#endif
