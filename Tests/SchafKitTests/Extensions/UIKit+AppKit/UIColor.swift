#if !os(watchOS)
import XCTest
import SchafKit

#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

class UIColorTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepresentation() {
        let white = UIColor.white
        
        XCTAssertEqual(white.rgbaRepresentation.red, 1)
    }
}
#endif
