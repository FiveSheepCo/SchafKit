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

class NetworkTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestInvalidURL() {
        let invalidURL = "///\n\\"
        
        OKNetworking.request(url: invalidURL) { (result) in
            XCTAssertEqual((result.failureValue as NSError?)?.code, 19027)
        }
    }
    
    func testRequests() {
        let googleURL = "http://google.com"
        
        let expectation = XCTestExpectation(description: "Basic Request Success")
        let expectation2 = XCTestExpectation(description: "Basic Options Request Success")
        
        OKNetworking.request(url: googleURL) { (result) in
            XCTAssertNil(result.failureValue)
            
            if result.value != nil {
                expectation.fulfill()
            }
        }
        
        let options : OKOptionSet<OKNetworking.Request.Options> = [.body(value: .xWwwFormUrlencoded(value: ["Test" : "Toast"])), .cachePolicy(value: .reloadIgnoringCacheData), .headerFields(value: [:]), .requestMethod(value: .post), .timeoutInterval(value: 10)]
        OKNetworking.request(url: googleURL, options: options) { (result) in
            XCTAssertNil(result.failureValue)
            
            if result.value != nil {
                expectation2.fulfill()
            }
        }
        
        wait(for: [expectation, expectation2], timeout: 10)
    }
    
    func testJsonResponse() {
        let expectation = XCTestExpectation(description: "JSON Request Success")
        
        let requestURL = "http://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.json"
        
        OKNetworking.request(url: requestURL) { (result) in
            if result.value!.jsonValue!.exists {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testEndpoint() {
        let googleURL = "http://www.google.com"
        let endpoint = OKNetworking.Endpoint(url: googleURL)
        
        let expectation = XCTestExpectation(description: "Basic Endpoint Request Success")
        
        endpoint.request(path: "imghp") { (result) in
            XCTAssertNil(result.failureValue)
            
            XCTAssertEqual(result.value?.response.response.url?.absoluteString, "http://www.google.com/imghp")
            
            if result.value != nil {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testEndpointAppendance() {
        let googleURL = "www.google.com"
        var endpoint = OKNetworking.Endpoint(url: googleURL)
        
        endpoint = endpoint.endpointByAppending(pathComponent: "imghp")
        
        XCTAssertEqual(endpoint.baseURL, "https://www.google.com/imghp")
    }
}
#endif
