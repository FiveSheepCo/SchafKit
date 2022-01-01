#if !os(watchOS)
import XCTest

class DoubleTests : XCTestCase {
    let locale = Locale(identifier: "en-US")
    let germanLocale = Locale(identifier: "de-DE")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToString() {
        let double = 1200.75
        
        XCTAssertEqual(double.toString, "1200.75")
        
        XCTAssertEqual(double.toFormattedString(locale: locale), "1,200.75")
        
        XCTAssertEqual(double.toFormattedString(decimals: 0, locale: locale), "1,201")
        
        XCTAssertEqual(double.toFormattedString(separatesThousands: false, locale: locale), "1200.75")
        
        XCTAssertEqual(double.toFormattedString(decimals: 0, separatesThousands: false, locale: locale), "1201")
    }
    
    func testToStringGerman() {
        let double = 1200.75
        
        XCTAssertEqual(double.toFormattedString(locale: germanLocale), "1.200,75")
        
        XCTAssertEqual(double.toFormattedString(decimals: 0, locale: germanLocale), "1.201")
        
        XCTAssertEqual(double.toFormattedString(separatesThousands: false, locale: germanLocale), "1200,75")
    }
}
#endif
