#if os(OSX) || os(iOS) || os(tvOS)
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
    
    @available(tvOS, unavailable)
    func testCatalogRepresentation() {
        #if os(macOS)
        let background = UIColor.textBackgroundColor
        #elseif os(tvOS)
        let background = UIColor.red
        #else
        let background = UIColor.placeholderText
        #endif
        
        XCTAssertTrue(background.rgbaRepresentation.red > 0)
    }
}
#endif
