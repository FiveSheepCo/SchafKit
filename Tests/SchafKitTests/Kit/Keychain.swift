import SchafKit
#if !os(watchOS)
import XCTest

class KeychainTests : XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // TODO: Fix
    /*
    func testSettingAndGettingPassword() {
        let id = NSUUID().uuidString
        let pass = NSUUID().uuidString
        
        let setResult = SKKeychain.set(password: pass, for: id)
        XCTAssertTrue(setResult)
        
        let getResult = SKKeychain.getPassword(for: id)
        XCTAssertEqual(pass, getResult)
    }
 */
}
#endif
