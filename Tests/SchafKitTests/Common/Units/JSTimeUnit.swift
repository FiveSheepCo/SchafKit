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

class OKTimeUnitTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpleConversion() {
        XCTAssertEqual(OKTimeUnit.minute.convert(to: .second), 60)
    }
    
    func testChainConversion() {
        XCTAssertEqual(
            OKTimeUnit.second.convert(to: .millisecond) *
            OKTimeUnit.minute.convert(to: .second) *
            OKTimeUnit.hour.convert(to: .minute) *
            OKTimeUnit.day.convert(to: .hour) *
            OKTimeUnit.year.convert(to: .day) *
            OKTimeUnit.decade.convert(to: .year) *
            OKTimeUnit.century.convert(to: .decade),
            1000 * 60 * 60 * 24 * 365 * 10 * 10)
    }
}
#endif
