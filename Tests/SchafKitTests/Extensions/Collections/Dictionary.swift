import Foundation
import SchafKit
#if !os(watchOS)
import XCTest

class DictionaryTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMerging() {
        var dict = [1: 1, 2: 2, 3: 3]
        let dict1 = dict
        let dict2 = [4: 2, 5: 3, 6: 4]
        
        dict += dict2
        
        XCTAssertEqual(dict, [1: 1, 2: 2, 3: 3, 4: 2, 5: 3, 6: 4])
        XCTAssertEqual(dict1 + dict2, [1: 1, 2: 2, 3: 3, 4: 2, 5: 3, 6: 4])
        
        XCTAssertEqual([String : String]() + [:], [:])
    }
    
    func testKeysForValue() {
        let dict = ["1": 1, "2": 2, "3": 1]
        let dict2 = ["4": 2, "5": 3, "6": 4]
        
        XCTAssertEqual(dict.keys(for: 1).sorted(), ["1", "3"])
        XCTAssertEqual(dict.keys(for: 2), ["2"])
        
        XCTAssertEqual(dict2.keys(for: 1), [])
        XCTAssertEqual(dict2.keys(for: 2), ["4"])
    }
}
#endif
