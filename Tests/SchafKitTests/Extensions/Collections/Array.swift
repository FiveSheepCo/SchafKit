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

#if !os(watchOS)
import XCTest

class ArrayTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRemoveFirstIfExists() {
        var array = [1, 2, 3]
        
        XCTAssertEqual(array.removeFirstIfExists(), 1)
        
        XCTAssertEqual(array.removeFirstIfExists(), 2)
        
        XCTAssertEqual(array.removeFirstIfExists(), 3)
        
        XCTAssertNil(array.removeFirstIfExists())
        
        array = [1, 2, 3]
        
        array.removeFirstIfExist(2)
        
        XCTAssertEqual(array, [3])
        
        array.removeFirstIfExist(2)
        
        XCTAssertEqual(array, [])
    }
    
    func testRemoveLastIfExists() {
        var array = [1, 2, 3]
        
        XCTAssertEqual(array.removeLastIfExists(), 3)
        
        XCTAssertEqual(array.removeLastIfExists(), 2)
        
        XCTAssertEqual(array.removeLastIfExists(), 1)
        
        XCTAssertNil(array.removeLastIfExists())
        
        array = [1, 2, 3]
        
        array.removeLastIfExist(2)
        
        XCTAssertEqual(array, [1])
        
        array.removeLastIfExist(2)
        
        XCTAssertEqual(array, [])
    }
    
    func testEndsWith() {
        let array = [1, 2, 3, 4, 5]
        
        XCTAssert(array.ends(with: [4, 5]))
        
        XCTAssert(array.ends(with: [1, 2, 3, 4, 5]))
        
        XCTAssertFalse(array.ends(with: [1, 2, 3, 4, 5, 6]))
        
        XCTAssertFalse(array.ends(with: [1, 2, 3]))
    }
    
    func testRemoveingDuplicates() {
        let array = [1, 2, 3, 4, 5]
        var array2 = [1, 2, 3, 4, 5, 5, 4, 3]
        
        XCTAssertEqual(array.removingDuplicates(), array)
        
        XCTAssertEqual(array2.removingDuplicates(), array)
        
        array2.removeDuplicates()
        
        XCTAssertEqual(array2, array)
    }
    
    func testRemoval() {
        var array = [1, 2, 3, 4, 5, 1]
        var array2 = [1, 2, 3, 4, 5, 5, 4, 3]
        var array3 = [Int]()
        
        array.remove(object: 1)
        XCTAssertEqual(array, [2, 3, 4, 5])
        
        array2.remove(object: 4)
        XCTAssertEqual(array2, [1, 2, 3, 5, 5, 3])
        
        array2.remove(object: 5)
        XCTAssertEqual(array2, [1, 2, 3, 3])
        
        array3.remove(object: 1)
        XCTAssertEqual(array3, [])
    }
    
    func testExactRemoval() {
        let objectA = NSObject()
        let objectB = NSObject()
        var array = [objectA, objectB]
        
        array.remove(exactObject: objectA)
        XCTAssertEqual(array, [objectB])
    }
    
    func testAny() {
        let arr = ["aaa", "aba", "aca", "ada", "aea"]
        XCTAssertTrue(arr.any({ $0.contains("c") }))
        XCTAssertFalse(arr.any({ $0.contains("f") }))
    }
}
#endif
