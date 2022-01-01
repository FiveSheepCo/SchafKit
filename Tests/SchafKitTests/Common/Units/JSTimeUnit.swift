import SchafKit
#if !os(watchOS)
import XCTest

class SKTimeUnitTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleConversion() {
        XCTAssertEqual(SKTimeUnit.minute.convert(to: .second), 60)
    }
    
    func testChainConversion() {
        XCTAssertEqual(
            SKTimeUnit.second.convert(to: .millisecond) *
            SKTimeUnit.minute.convert(to: .second) *
            SKTimeUnit.hour.convert(to: .minute) *
            SKTimeUnit.day.convert(to: .hour) *
            SKTimeUnit.year.convert(to: .day) *
            SKTimeUnit.decade.convert(to: .year) *
            SKTimeUnit.century.convert(to: .decade),
            1000 * 60 * 60 * 24 * 365 * 10 * 10)
    }
    
    func testChainCompleteConversion() {
        XCTAssertEqual(
            SKTimeUnit.century.convert(to: .millisecond),
            1000 * 60 * 60 * 24 * 365 * 10 * 10)
    }
}
#endif
