#if !os(watchOS)
import XCTest

class NSRegularExpressionTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertNil(try? NSRegularExpression(pattern: "toast)("))
        
        let pattern = "toast()"
        XCTAssertEqual((try? NSRegularExpression(pattern: pattern))?.pattern, pattern)
    }
}
#endif
