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

import Foundation

import SchafKit
#if !os(watchOS)
import XCTest

class OKJsonRepresentableTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNilValues() {
        let original = OKJsonRepresentable(object: nil)
        let original2 = OKJsonRepresentable(jsonRepresentation: nil as Data?)
        
        XCTAssertFalse(original.exists)
        XCTAssertFalse(original2.exists)
    }
    
    func testReversal() {
        let original = OKJsonRepresentable(object: ["Hey": "Ho", "Ho": 2, "Toast": ["Test"]])
        
        for rep in [original, OKJsonRepresentable(jsonRepresentation: original.jsonRepresentation), OKJsonRepresentable(jsonRepresentation : String(data: original.jsonRepresentation!, encoding: .utf8))]{
            XCTAssertNotNil(rep.jsonRepresentation)
            
            XCTAssertTrue(rep.exists)
            XCTAssertNil(rep.boolValue)
            
            XCTAssertEqual(rep["Hey"].stringValue, "Ho")
            XCTAssertNil(rep["Hey"].intValue)
            
            XCTAssertEqual(rep["Ho"].intValue, 2)
            XCTAssertEqual(rep["Ho"].doubleValue, 2.0)
            XCTAssertNil(rep["Ho"].stringValue)
            
            XCTAssertFalse(rep["Test"].exists)
            
            XCTAssertTrue(rep["Toast"].exists)
            XCTAssertTrue(rep["Toast"][0].exists)
            XCTAssertEqual(rep["Toast"][0].stringValue, "Test")
        }
    }
    
    func testNilability() {
        let originals = [OKJsonRepresentable(object: nil), OKJsonRepresentable(jsonRepresentation: nil as Data?), OKJsonRepresentable(jsonRepresentation: nil as String?)]
        
        for original in originals {
            XCTAssertNotNil(original[0])
            
            XCTAssertNil(original.jsonRepresentation)
        }
    }
    
    func testEditing() {
        let original = OKJsonRepresentable(object: ["a": "Ho", "b": 2, "c": ["c1": "Tests"]])
        
        original["a"] = OKJsonRepresentable(object: nil)
        original["c"]["c1"] = OKJsonRepresentable(object: nil)
        
        XCTAssertNil(original["a"].value)
        XCTAssertNil(original["c"]["c1"].value)
    }
}
#endif
