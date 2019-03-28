//
//  StoreKit.swift
//  Utility
//
//  Created by Daniele Citi on 11/03/2019.
//  Copyright © 2019 Daniele Citi. All rights reserved.
//

import Foundation
 /*
 func restorePurchaseWithNoSegue(delegate: UIViewController)
 {
 SwiftyStoreKit.restorePurchases(atomically: true) { results in
 if results.restoreFailedPurchases.count > 0 {
 print("Restore Failed: \(results.restoreFailedPurchases)")
 createAlertNoSegue(title: "Failed", message: "Failed to restore the purchase", delegate: delegate)
 }
 else if results.restoredPurchases.count > 0 {
 print("Restore Success: \(results.restoredPurchases)")
 createAlertNoSegue(title: "Success!", message: "Purchase restored!", delegate: delegate)
 }
 else {
 print("Nothing to Restore")
 createAlertNoSegue(title: "Nothing to restore!", message: "There is nothing to restore.", delegate: delegate)
 }
 }
 }
 
 func createAlertNoSegue(title:String, message: String, delegate: UIViewController)
 {
 let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
 
 alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
 alert.dismiss(animated: true, completion: nil)
 }))
 delegate.present(alert, animated: true, completion: nil)
 }
 
 enum PurchaseType: Int
 {
 case simple = 0,
 autoRenewable,
 nonRenewing
 }
 
 
 func purchaseProduct(with id: String, type: PurchaseType, validDuration: TimeInterval? = nil, delegate: UIViewController)
 {
 if type == .simple
 {
 SwiftyStoreKit.retrieveProductsInfo([id]) { result in
 if let product = result.retrievedProducts.first {
 SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
 // handle result (same as above)
 switch result {
 case .success(let product):
 // fetch content from your server, then:
 if product.needsFinishTransaction {
 SwiftyStoreKit.finishTransaction(product.transaction)
 }
 print("Purchase Success: \(product.productId)")
 createAlertNoSegue(title: "Purchase successful!", message: "You removed ADS!", delegate: delegate)
 UserDefaults.standard.set(true, forKey: "purchased")
 case .error(let error):
 switch error.code { // finire
 case .unknown:
 createAlertNoSegue(title: "Unknown error.", message: "Please contact support", delegate: delegate)
 UserDefaults.standard.set(false, forKey: "purchased")
 case .clientInvalid:
 createAlertNoSegue(title: "Error.", message: "Not allowed to make the payment", delegate: delegate)
 UserDefaults.standard.set(false, forKey: "purchased")
 case .paymentCancelled:
 break
 case .paymentInvalid:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "The purchase identifier was invalid", delegate: delegate)
 case .paymentNotAllowed:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "The device is not allowed to make the payment", delegate: delegate)
 case .storeProductNotAvailable:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "The product is not available in the current storefront", delegate: delegate)
 case .cloudServicePermissionDenied:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "Access to cloud service information is not allowed", delegate: delegate)
 case .cloudServiceNetworkConnectionFailed:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "Could not connect to the network", delegate: delegate)
 case .cloudServiceRevoked:
 UserDefaults.standard.set(false, forKey: "purchased")
 createAlertNoSegue(title: "Error.", message: "User has revoked permission to use this cloud service", delegate: delegate)
 }
 }
 }
 }
 }
 }
 }
 
 func verifyPurchase(with id: String, type: PurchaseType, validDuration: TimeInterval? = nil, delegate: UIViewController)
 {
 // NON FUNZIONA SU SIMULATORE, SOLO DEVICE REALE con accesso eseguito come SandBoxTester
 
 let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
 SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
 switch result {
 case .success(let receipt):
 
 // Verify the purchase of a Subscription
 switch type {
 case .simple:
 let purchaseResult = SwiftyStoreKit.verifyPurchase(
 productId: id,
 inReceipt: receipt)
 switch purchaseResult {
 case .purchased(let receiptItem):
 print("product is purchased \(receiptItem)")
 // gia comprato
 let alert = UIAlertController(title: "Already purchased!", message: "You have already purchased this item.", preferredStyle: UIAlertController.Style.alert)
 alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
 alert.dismiss(animated: true, completion: nil)
 }))
 delegate.present(alert, animated: true, completion: nil)
 
 case .notPurchased:
 print("The user has never purchased \(id)")
 // Non ancora comprato
 let alert = UIAlertController(title: "Remove ADS?", message: "Remove ads for 1€.", preferredStyle: UIAlertController.Style.alert)
 alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
 // acquista
 purchaseProduct(with: id, type: type, validDuration: nil, delegate: delegate)
 }))
 alert.addAction(UIAlertAction.init(title: "No", style: UIAlertAction.Style.cancel, handler: { (action) in
 alert.dismiss(animated: true, completion: nil)
 }))
 delegate.present(alert, animated: true, completion: nil)
 }
 case .autoRenewable:
 break
 case .nonRenewing:
 break
 }
 case .error(let error):
 print("Receipt verification failed: \(error)")
 
 }
 }
 }
 
 func verifyPurchaseForAds(with id: String)
 {
 // NON FUNZIONA SU SIMULATORE, SOLO DEVICE REALE con accesso eseguito come SandBoxTester
 let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
 
 SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
 switch result {
 case .success(let receipt):
 
 let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: id,inReceipt: receipt)
 
 switch purchaseResult {
 case .purchased(let receiptItem):
 print("product is purchased \(receiptItem)")
 UserDefaults.standard.set(true, forKey: "purchased")
 case .notPurchased:
 print("The user has never purchased \(id)")
 UserDefaults.standard.set(false, forKey: "purchased")
 }
 case .error(let error):
 print("Receipt verification failed: \(error)")
 }
 }
 }
 
 
 */

