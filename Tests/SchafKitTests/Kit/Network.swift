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
        
        SKNetworking.request(url: invalidURL) { (result) in
            XCTAssertEqual((result.failureValue as NSError?)?.code, 19027)
        }
    }
    
    func testRequests() {
        let googleURL = "http://google.com"
        
        let expectation = XCTestExpectation(description: "Basic Request Success")
        let expectation2 = XCTestExpectation(description: "Basic Options Request Success")
        
        SKNetworking.request(url: googleURL) { (result) in
            XCTAssertNil(result.failureValue)
            
            if result.value != nil {
                expectation.fulfill()
            }
        }
        
        let options : SKOptionSet<SKNetworking.Request.Options> = [.body(value: .xWwwFormUrlencoded(value: ["Test" : "Toast"])), .cachePolicy(value: .reloadIgnoringCacheData), .headerFields(value: [:]), .requestMethod(value: .post), .timeoutInterval(value: 10)]
        SKNetworking.request(url: googleURL, options: options) { (result) in
            XCTAssertNil(result.failureValue)
            
            if result.value != nil {
                expectation2.fulfill()
            }
        }
        
        wait(for: [expectation, expectation2], timeout: 10)
    }
    
    func testJsonResponse() {
        let expectation = XCTestExpectation(description: "JSON Request Success")
        
        let requestURL = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
        
        SKNetworking.request(url: requestURL) { (result) in
            if result.value!.jsonValue!.exists {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testEndpoint() {
        let googleURL = "http://www.google.com"
        let endpoint = SKNetworking.Endpoint(url: googleURL)
        
        let expectation = XCTestExpectation(description: "Basic Endpoint Request Success")
        
        endpoint.request(path: "imghp") { (result) in
            XCTAssertNil(result.failureValue)
            
            XCTAssertEqual(result.value?.response.response.url?.absoluteString.starts(with: "http://www.google.com/imghp") ?? false || result.value?.response.response.url?.absoluteString.starts(with: "https://www.google.com/imghp") ?? false, true)
            
            if result.value != nil {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testEndpointAppendance() {
        let googleURL = "www.google.com"
        var endpoint = SKNetworking.Endpoint(url: googleURL)
        
        endpoint = endpoint.endpointByAppending(pathComponent: "imghp")
        
        XCTAssertEqual(endpoint.baseURL, "https://www.google.com/imghp")
    }
}
#endif
