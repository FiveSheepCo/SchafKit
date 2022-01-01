import SchafKit
#if !os(watchOS)
import XCTest

class SKUnitTests : XCTestCase {
    let locale = Locale(identifier: "en-US")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testByteConversion() {
        XCTAssertEqual(SKUnit.getByteSizeString(from: 60, locale: locale), "60 B")
        
        XCTAssertEqual(SKUnit.getByteSizeString(from: 60123, locale: locale), "60.12 KB")
        XCTAssertEqual(SKUnit.getByteSizeString(from: 60123, useAbbreviation: false, locale: locale), "60.12 Kilobyte")
        
        XCTAssertEqual(SKUnit.getByteSizeString(from: 60123000, locale: locale), "60.12 MB")
    }
    
    func testBitConversion() {
        XCTAssertEqual(SKUnit.getBitSizeString(from: 60, locale: locale), "60 bit")
        
        XCTAssertEqual(SKUnit.getBitSizeString(from: 60123, locale: locale), "60.12 Kbit")
        XCTAssertEqual(SKUnit.getBitSizeString(from: 60123, useAbbreviation: false, locale: locale), "60.12 Kilobit")
        
        XCTAssertEqual(SKUnit.getBitSizeString(from: 60123000, locale: locale), "60.12 Mbit")
    }
}
#endif
