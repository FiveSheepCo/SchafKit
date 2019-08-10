#if !os(watchOS)
import XCTest
import OpenKit

#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

class UIImageTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndsWith() {
        let image = UIImage(named: "TestImage.jpg", in : Bundle(for: self.classForCoder))!
        
        let colors = image.colorRepresentations
        let extractedColor = colors[99][1]
        
        XCTAssertEqual(extractedColor.red, 172)
        XCTAssertEqual(extractedColor.green, 195)
        XCTAssertEqual(extractedColor.blue, 210)
        XCTAssertEqual(extractedColor.alpha, 255)
        
        let color = image.colorRepresentation(at : CGPoint.zero)
        
        XCTAssertEqual(color.red, 171)
        XCTAssertEqual(color.green, 190)
        XCTAssertEqual(color.blue, 204)
        XCTAssertEqual(color.alpha, 255)
    }
    
    func testSingleColorRepresentation() {
        let image = UIImage(named: "TestImage.jpg", in : Bundle(for: self.classForCoder))!
        
        self.measure() {
            _ = image.colorRepresentation(at : CGPoint.zero)
        }
    }
    
    func testAllColorRepresentations() {
        let image = UIImage(named: "TestImage.jpg", in : Bundle(for: self.classForCoder))!
        
        self.measure() {
            _ = image.colorRepresentations
        }
    }
    
    func testAllColorRepresentationsForBigImage() {
        //let image = UIImage(named: "TestImageBig.jpg", in : Bundle(for: self.classForCoder))!
        let image = UIImage(named: "TestImage.jpg", in : Bundle(for: self.classForCoder))!
        
        self.measure() {
            _ = image.colorRepresentations
        }
    }
}

#endif