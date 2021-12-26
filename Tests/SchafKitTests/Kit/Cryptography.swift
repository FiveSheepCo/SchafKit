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

#if canImport(TweetNacl)
import SchafKit
#if !os(watchOS)
import XCTest

class CryptographyTests : XCTestCase {
    let randomData = Data(randomWith: 1024)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Data
    
    func testDataRandomness() {
        XCTAssertNotEqual(Data(randomWith: 64), Data(randomWith: 64))
    }
    
    // MARK: - Ed25519
    
    let ed25519 = SKCryptography.Ed25519Algorithm.self
    lazy var edKeyPair = ed25519.KeyPair()
    
    func testSignatureKeyRandomness() {
        let otherEdKeyPair = ed25519.KeyPair()
        
        XCTAssertNotEqual(edKeyPair.publicKey, edKeyPair.privateKey)
        
        XCTAssertNotEqual(edKeyPair.privateKey, otherEdKeyPair.privateKey)
        XCTAssertNotEqual(edKeyPair.publicKey, otherEdKeyPair.publicKey)
    }
    
    func testSignatureValidation() {
        let signedData = ed25519.sign(randomData, with: edKeyPair.privateKey)
        
        let unsignedData = ed25519.open(signedData, with: edKeyPair.publicKey)
        
        XCTAssertNotEqual(signedData, unsignedData)
        XCTAssertEqual(randomData, unsignedData)
        
        let validation = ed25519.validate(signedData: signedData, publicKey: edKeyPair.publicKey)
        
        XCTAssertTrue(validation)
    }
    
    func testSignatureValidationFailByPassingOriginalAsSignedData() {
        _ = ed25519.sign(randomData, with: edKeyPair.privateKey)
        
        let validation = ed25519.validate(signedData: randomData, publicKey: edKeyPair.publicKey)
        
        XCTAssertFalse(validation)
    }
    
    func testSignatureValidationFailingByPassingRandomAsSigned() {
        let validation = ed25519.validate(signedData: Data(randomWith: 128), publicKey: edKeyPair.publicKey)
        
        XCTAssertFalse(validation)
    }
    
    // MARK: - XSalsa20Poly1305 SecretBox
    
    let secretBox = SKCryptography.XSalsa20Poly1305SecretBoxAlgorithm.self
    lazy var xsalsaKey = secretBox.Key().privateKey
    lazy var xsalsaNonce = secretBox.Nonce().nonce
    
    func testSymmetricalKeyRandomness() {
        let otherXSalsaKey = secretBox.Key().privateKey
        
        XCTAssertNotEqual(xsalsaKey, otherXSalsaKey)
    }
    
    func testSymmetricalNonceRandomness() {
        let otherXSalsaNonce = secretBox.Nonce().nonce
        
        XCTAssertNotEqual(xsalsaNonce, otherXSalsaNonce)
    }
    
    func testSymmetricalEnDecryption() {
        let encryptedData = secretBox.encrypt(randomData, with: xsalsaKey, nonce: xsalsaNonce)
        let decryptedData = secretBox.decrypt(encryptedData, with: xsalsaKey, nonce: xsalsaNonce)
        
        XCTAssertEqual(encryptedData.count - randomData.count, 32)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertEqual(randomData, decryptedData)
    }
    
    func testSymmetricalEnDecryptionFailingDueToDifferentKey() {
        let otherXSalsaKey = secretBox.Key().privateKey
        
        let encryptedData = secretBox.encrypt(randomData, with: xsalsaKey, nonce: xsalsaNonce)
        let decryptedData = secretBox.decrypt(encryptedData, with: otherXSalsaKey, nonce: xsalsaNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testSymmetricalEnDecryptionFailingDueToDifferentNonce() {
        let otherXSalsaNonce = secretBox.Nonce().nonce
        
        let encryptedData = secretBox.encrypt(randomData, with: xsalsaKey, nonce: xsalsaNonce)
        let decryptedData = secretBox.decrypt(encryptedData, with: xsalsaKey, nonce: otherXSalsaNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testSymmetricalEnDecryptionFailingDueToDifferentKeyAndNonce() {
        let otherXSalsaNonce = secretBox.Nonce().nonce
        let otherXSalsaKey = secretBox.Key().privateKey
        
        let encryptedData = secretBox.encrypt(randomData, with: xsalsaKey, nonce: xsalsaNonce)
        let decryptedData = secretBox.decrypt(encryptedData, with: otherXSalsaKey, nonce: otherXSalsaNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testSymmetricalEnDecryptionWithAppendedNonce() {
        let encryptedData = secretBox.encryptWithRandomNonceAppended(randomData, with: xsalsaKey)
        let decryptedData = secretBox.decryptWithNonceAppended(encryptedData, with: xsalsaKey)
        
        XCTAssertEqual(encryptedData.count - randomData.count, 24 + 32)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertEqual(randomData, decryptedData)
    }
    
    func testSymmetricalEnDecryptionWithAppendedNonceFailingDueToDifferentKey() {
        let otherXSalsaKey = secretBox.Key().privateKey
        
        let encryptedData = secretBox.encryptWithRandomNonceAppended(randomData, with: xsalsaKey)
        let decryptedData = secretBox.decryptWithNonceAppended(encryptedData, with: otherXSalsaKey)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    // MARK: - Curve25519XSalsa20Poly1305 Box
    
    let box = SKCryptography.Curve25519XSalsa20Poly1305BoxAlgorithm.self
    lazy var localBoxKeyPair = box.KeyPair()
    lazy var remoteBoxKeyPair = box.KeyPair()
    lazy var boxNonce = box.Nonce().nonce
    
    func testBoxKeyRandomness() {
        XCTAssertNotEqual(localBoxKeyPair.publicKey, localBoxKeyPair.privateKey)
        
        XCTAssertNotEqual(localBoxKeyPair.privateKey, remoteBoxKeyPair.privateKey)
        XCTAssertNotEqual(localBoxKeyPair.publicKey, remoteBoxKeyPair.publicKey)
    }
    
    func testAsymmetricalEnDecryption() {
        let encryptedData = box.encrypt(randomData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.publicKey, nonce: boxNonce)
        let decryptedData = box.decrypt(encryptedData, with: remoteBoxKeyPair.privateKey, publicKey: localBoxKeyPair.publicKey, nonce: boxNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertEqual(randomData, decryptedData)
    }
    
    func testAsymmetricalEnDecryptionFailDueToDifferentPrivateKey() {
        let encryptedData = box.encrypt(randomData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.privateKey, nonce: boxNonce)
        let decryptedData = box.decrypt(encryptedData, with: localBoxKeyPair.privateKey, publicKey: localBoxKeyPair.publicKey, nonce: boxNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testAsymmetricalEnDecryptionFailDueToDifferentPublicKey() {
        let encryptedData = box.encrypt(randomData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.privateKey, nonce: boxNonce)
        let decryptedData = box.decrypt(encryptedData, with: remoteBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.publicKey, nonce: boxNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testAsymmetricalEnDecryptionFailDueToDifferentPrivateAndPublicKey() {
        let encryptedData = box.encrypt(randomData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.privateKey, nonce: boxNonce)
        let decryptedData = box.decrypt(encryptedData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.publicKey, nonce: boxNonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testAsymmetricalEnDecryptionFailDueToDifferentNonce() {
        let encryptedData = box.encrypt(randomData, with: localBoxKeyPair.privateKey, publicKey: remoteBoxKeyPair.privateKey, nonce: boxNonce)
        let decryptedData = box.decrypt(encryptedData, with: remoteBoxKeyPair.privateKey, publicKey: localBoxKeyPair.publicKey, nonce: box.Nonce().nonce)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
    
    func testAsymmetricalEnDecryptionWithAppendedNonceAndPublicKey() {
        let encryptedData = box.encryptWithRandomNonceAndPublicKeyAppended(randomData, with: remoteBoxKeyPair.publicKey, ownKeyPair: localBoxKeyPair)
        let decryptedData = box.decryptWithNonceAndPublicKeyAppended(encryptedData, with: remoteBoxKeyPair.privateKey)
        
        XCTAssertEqual(encryptedData.count - randomData.count, 32 + 32 + 24)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertEqual(randomData, decryptedData)
    }
    
    func testAsymmetricalEnDecryptionWithAppendedNonceAndPublicKeyFailingDueToDifferentKey() {
        let encryptedData = box.encryptWithRandomNonceAndPublicKeyAppended(randomData, with: remoteBoxKeyPair.publicKey, ownKeyPair: localBoxKeyPair)
        let decryptedData = box.decryptWithNonceAndPublicKeyAppended(encryptedData, with: localBoxKeyPair.privateKey)
        
        XCTAssertNotEqual(encryptedData, decryptedData)
        XCTAssertNotEqual(randomData, decryptedData)
        XCTAssertNil(decryptedData)
    }
}
#endif
#endif
