//  Copyright (c) 2020 Quintschaf GbR
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
