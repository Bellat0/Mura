//
//  SubscriptionService.swift
//  Mura
//
//  Created by Maxim Tvilinev on 17.11.2023.
//

import Foundation
import StoreKit

class SubscriptionService: NSObject {

    // MARK: - Properties

    var request: SKProductsRequest!
    var completion: (([SKProduct]) -> Void)?
    var productPurchaseCallback: ((Bool) -> Void)?
    var isPurchased: Bool = true

    // MARK: - Init

    override init() {
        super.init()

        SKPaymentQueue.default().add(self)
    }


    // MARK: - Methods

    func validate(productIdentifiers: [String], completion: @escaping ([SKProduct]) -> Void) {
        self.completion = completion
        let productIdentifiers = Set(productIdentifiers)


        request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }

    func  purchase(product: SKProduct, callBack: @escaping (Bool) -> Void) {
        self.productPurchaseCallback = callBack
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

// MARK: -

extension SubscriptionService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

        let products = response.products

        completion?(products)
    }
}

// MARK: -

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}

// MARK: -

extension SubscriptionService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // 1:
        for transaction in transactions {
            switch transaction.transactionState {
                // 2:
            case .purchased, .restored:
                isPurchased = true

                if finishTransaction(transaction) {
                    SKPaymentQueue.default().finishTransaction(transaction)
                    productPurchaseCallback?(true)
                } else {
                    productPurchaseCallback?(false)
                }
                // 3:
            case .failed:
                productPurchaseCallback?(false)
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }

    func finishTransaction(_ transaction: SKPaymentTransaction) -> Bool {
        let productId = transaction.payment.productIdentifier
        print("Product \(productId) successfully purchased")
        return true
    }
}
