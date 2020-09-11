//
//  JSStoreKitHelper.swift
//  Keyboard
//
//  Created by Jann Schafranek on 06.03.19.
//  Copyright © 2019 Jann Thomas. All rights reserved.
//

import Foundation
import StoreKit

public typealias SKPurchaseHandler = (Bool) -> Void
public typealias SKProductFetchCompletionHandler = ((Result<SKProduct, Error>) -> Void)
public typealias SKProductsFetchCompletionHandler = ((Result<[SKProduct], Error>) -> Void)

public class SKStoreKitHelper {
    public static let shared = SKStoreKitHelper()
    
    private let queueHelper = _SKPaymentQueueHelper.shared
    
    public func requestInAppProduct(for identifier : String,
                                    completionHandler : @escaping SKProductFetchCompletionHandler
    ) {
        self.requestInAppProducts(for: [identifier], completionHandler: { (products) in
            completionHandler(products.map{ $0.first! })
        })
    }
    
    public func requestInAppProducts(
        for identifiers : Set<String>,
        completionHandler : @escaping SKProductsFetchCompletionHandler
    ) {
        let request = _SKStoreKitProductRequest(productIdentifiers: identifiers)
        
        request.completionHandler = completionHandler
        
        request.start()
    }
    
    public func purchase(
        product : SKProduct,
        completionHandler : @escaping SKPurchaseHandler
    ) {
        queueHelper.purchase(product: product, completionHandler: completionHandler)
    }
    
    public func restorePurchases(completionHandler : @escaping SKPurchaseHandler) {
        queueHelper.restorePurchases(completionHandler: completionHandler)
    }
    
    public func isPurchased(identifier : String) -> Bool {
        return UserDefaults.standard.bool(forKey: "IAP-Purchased-\(identifier)")
    }
}

internal class _SKPaymentQueueHelper : NSObject, SKPaymentTransactionObserver {
    static let shared = _SKPaymentQueueHelper()
    
    let paymentQueue = SKPaymentQueue.default()
    var completionHandlers : [String : [SKPurchaseHandler]] = [:]
    var restoreHandlers : [SKPurchaseHandler] = []
    
    override private init() {
        super.init()
        
        paymentQueue.add(self)
    }
    
    func purchase(product : SKProduct,
                  completionHandler : @escaping SKPurchaseHandler)
    {
        let payment = SKPayment(product: product)
        
        completionHandlers[product.productIdentifier] = (completionHandlers[product.productIdentifier] ?? []) + [completionHandler]
        
        paymentQueue.add(payment)
    }
    
    func restorePurchases(completionHandler : @escaping SKPurchaseHandler) {
        restoreHandlers.append(completionHandler)
        paymentQueue.restoreCompletedTransactions()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            let handlers = completionHandlers[transaction.payment.productIdentifier] ?? []
            
            guard [.purchased, .restored, .failed].contains(transaction.transactionState) else {
                return
            }
            
            let isDone = [.purchased, .restored].contains(transaction.transactionState)
            for handler in handlers {
                handler(isDone)
            }
            completionHandlers[transaction.payment.productIdentifier] = nil
            
            if isDone {
                UserDefaults.standard.set(true, forKey: "IAP-Purchased-\(transaction.payment.productIdentifier)")
            } else {
                OKAlerting.showAlert(title: "Error", message: "There was a problem with your In-App Purchase: \(transaction.error?.localizedDescription ?? "Unknown error.")")
            }
            queue.finishTransaction(transaction)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        for handler in restoreHandlers {
            handler(false)
        }
        restoreHandlers = []
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for handler in restoreHandlers {
            handler(true)
        }
        restoreHandlers = []
    }
}

internal class _SKStoreKitProductRequest : NSObject, SKProductsRequestDelegate {
    private static var currentRequests : [_SKStoreKitProductRequest] = []
    
    var completionHandler : SKProductsFetchCompletionHandler?
    private let request : SKProductsRequest
    
    init(productIdentifiers : Set<String>) {
        request = SKProductsRequest(productIdentifiers: productIdentifiers)
        
        super.init()
        
        request.delegate = self
        
        _SKStoreKitProductRequest.currentRequests.append(self)
    }
    
    func start() {
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        completionHandler?(.success(response.products))
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        completionHandler?(.failure(error))
    }
    
    func requestDidFinish(_ request: SKRequest) {
        _SKStoreKitProductRequest.currentRequests.remove(object: self)
    }
}
