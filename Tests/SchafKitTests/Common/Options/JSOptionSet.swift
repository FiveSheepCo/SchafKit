import SchafKit
#if !os(watchOS)
import XCTest

fileprivate enum ExampleOptions : SKOptions {
    case first(value : String)
    case second(value : Int)
}

class SKOptionSetTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExampleOptions() {
        var set : SKOptionSet = [ExampleOptions.first(value: "a"), ExampleOptions.second(value: 1)]
        
        var result : String = ""
        for case .first(let value) in set {
            result = value
        }
        XCTAssertEqual(result, "a")
        
        set += [ExampleOptions.first(value: "b")]
        
        var times = 0
        for case .first(let value) in set {
            result = value
            times+=1
        }
        XCTAssertEqual(result, "b")
        XCTAssertEqual(times, 1)
        
        set += ExampleOptions.second(value: 2)
        
        times = 0
        for case .first(let value) in set {
            result = value
            times+=1
        }
        XCTAssertEqual(result, "b")
        XCTAssertEqual(times, 1)
    }
}
#endif
