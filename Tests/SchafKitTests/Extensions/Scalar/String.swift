#if !os(watchOS)
import XCTest

class StringTests : XCTestCase {
    let locale = Locale(identifier: "en-US")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstants() {
        XCTAssertEqual(String.empty, "")
        
        XCTAssertEqual(String.space, " ")
        
        XCTAssertEqual(String.newline, "\n")
    }
    
    func testEndsWith() {
        let string = "OpenKit"
        
        XCTAssert(string.ends(with: "t"))
        
        XCTAssert(string.ends(with: "Kit"))
        
        XCTAssertFalse(string.ends(with: "Ki"))
        
        XCTAssertFalse(string.ends(with: "JS"))
        
        XCTAssertFalse(String.empty.ends(with: "JS"))
    }
    
    func testLines(){
        let string = "OpenKit\nAvailable at https://github.com/JannSchafranek/OpenKit"
        let stringB = "OpenKit"
        
        XCTAssertEqual(string.lines, ["OpenKit", "Available at https://github.com/JannSchafranek/OpenKit"])
        
        XCTAssertEqual(stringB.lines, ["OpenKit"])
        
        XCTAssertEqual(String.empty.lines, [""])
    }
    
    func testEncodingDecoding() {
        let url = "https://github.com/JannSchafranek/OpenKit"
        let encodedUrl = url.urlEncoded
        
        XCTAssertEqual(encodedUrl, "https%3A%2F%2Fgithub.com%2FJannSchafranek%2FOpenKit")
        
        let decodedUrl = encodedUrl.urlDecoded
        
        XCTAssertEqual(decodedUrl, url)
    }
    
    func testEncodingDecodingFail() {
        let url = String(bytes: [0xD8, 0x00] as [UInt8], encoding : String.Encoding.utf16BigEndian)!
        let encodedUrl = url.urlEncoded
        
        XCTAssertEqual(encodedUrl, url)
        
        let decodedUrl = encodedUrl.urlDecoded
        
        XCTAssertEqual(decodedUrl, url)
    }
    
    func testRemovingOccurances() {
        let string = "test"
        
        XCTAssertEqual(string.removingOccurances(of: "s"), "tet")
        
        XCTAssertEqual(string.removingOccurances(of: "t"), "es")
        
        let stringB = "testtestest"
        
        XCTAssertEqual(stringB.removingOccurances(of: "t"), "eseses")
        
        XCTAssertEqual(stringB.removingOccurancesAtStart(of: "t"), "esttestest")
        
        XCTAssertEqual(stringB.removingOccurancesAtEnd(of: "t"), "testtestes")
        
        let stringC = "&nbsp;&nbsp;&nbsp;testt"
        
        XCTAssertEqual(stringC.removingOccurancesAtStart(of: "&nbsp;"), "testt")
        
        XCTAssertEqual(stringC.removingOccurancesAtEnd(of: "t"), "&nbsp;&nbsp;&nbsp;tes")
    }
    
    func testMutating() {
        var string = "test"
        
        string.capitalize()
        XCTAssertEqual(string, "Test")
        
        string.lowercase()
        XCTAssertEqual(string, "test")
        
        string.uppercase()
        XCTAssertEqual(string, "TEST")
        
        string.replaceOccurances(of: "E", with: "low")
        XCTAssertEqual(string, "TlowST")
        
        string.removeOccurances(of: "low")
        XCTAssertEqual(string, "TST")
    }
    
    func testMutablyEncodingDecoding() {
        let originalUrl = "https://github.com/JannSchafranek/OpenKit"
        var url = originalUrl
        
        url.urlEncode()
        
        XCTAssertEqual(url, "https%3A%2F%2Fgithub.com%2FJannSchafranek%2FOpenKit")
        
        url.urlDecode()
        
        XCTAssertEqual(url, originalUrl)
    }
    
    func testSaneSubstringFunctions(){
        let string = "TestToastWords"
        
        XCTAssertEqual(string[...3], "Test")
        
        XCTAssertEqual(string[..<4], "Test")
        
        XCTAssertEqual(string[4..<9], "Toast")
        
        XCTAssertEqual(string[4...8], "Toast")
        
        XCTAssertEqual(string[9...], "Words")
    }
    
    func testToInt(){
        let string = "0"
        let stringB = "1000"
        let stringC = "-5000"
        let stringD = "test"
        
        XCTAssertEqual(string.toInt, 0)
        
        XCTAssertEqual(stringB.toInt, 1000)
        
        XCTAssertEqual(stringC.toInt, -5000)
        
        XCTAssertEqual(stringD.toInt, nil)
    }
    
    func testToDouble(){
        let string = "0"
        let stringB = "1000"
        let stringC = "-5000"
        let stringD = "test"
        let stringE = "2777.25"
        let stringF = "-0.25"
        
        XCTAssertEqual(string.toDouble, 0)
        
        XCTAssertEqual(stringB.toDouble, 1000)
        
        XCTAssertEqual(stringC.toDouble, -5000)
        
        XCTAssertNil(stringD.toDouble)
        
        XCTAssertEqual(stringE.toDouble, 2777.25)
        
        XCTAssertEqual(stringF.toDouble, -0.25)
    }
    
    func testFormattedToDouble(){
        let string = "1,000,000.00"
        
        XCTAssertEqual(string.formattedToDouble(locale: locale), 1000000)
        
        let stringB = "1,000,000.005"
        
        XCTAssertEqual(stringB.formattedToDouble(locale: locale), 1000000.005)
    }
    
    func testExtractedSeconds() {
        XCTAssertEqual("00:00:00".extractedSeconds, 0)
        
        XCTAssertEqual("00:00:15".extractedSeconds, 15)
        
        XCTAssertEqual("00:20:15".extractedSeconds, 1215)
        
        XCTAssertEqual("04:00:00".extractedSeconds, 14400)
        
        XCTAssertEqual("12:18:24".extractedSeconds, 44304)
        
        
        XCTAssertEqual("15".extractedSeconds, 15)
        
        XCTAssertEqual("0:15".extractedSeconds, 15)
        
        XCTAssertEqual("20:15".extractedSeconds, 1215)
        
        XCTAssertEqual("4:00:00".extractedSeconds, 14400)
        
        
        XCTAssertEqual("".extractedSeconds, 0)
    }
    
    func testRegexValidation(){
        let string = "test"
        let stringB = "test("
        
        XCTAssert(string.isValidRegEx)
        
        XCTAssertFalse(stringB.isValidRegEx)
    }
    
    func testRegex(){
        let regex = "t(e)(s)t"
        let regexB = "test("
        let regexC = "test(a)?"
        let string = "toasttesttoasttest"
        
        let matches = string.regexMatches(with: regex)
        
        XCTAssertEqual(matches?.count, 2)
        
        
        XCTAssertEqual(matches?[0].result, "test")
        
        XCTAssertEqual(matches?[0].range, NSRange(location: 5, length: 4))
        
        
        XCTAssertEqual(matches?[0].captureGroups.count, 2)
        
        XCTAssertEqual(matches?[0].captureGroups[0], "e")
        
        XCTAssertEqual(matches?[0].captureGroupRanges[0], NSRange(location: 6, length: 1))
        
        
        XCTAssertNil(string.regexMatches(with: regexB))
        
        XCTAssertNil(string.regexMatches(with: regexC)![0].captureGroups[0])
    }
}
#endif
