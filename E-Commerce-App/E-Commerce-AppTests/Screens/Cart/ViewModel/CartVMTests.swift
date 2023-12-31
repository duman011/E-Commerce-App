//
//  CartVMTests.swift
//  E-Commerce-AppTests
//
//  Created by Erislam Nurluyol on 30.11.2023.
//

import XCTest
@testable import E_Commerce_App

final class CartVMTests: XCTestCase {
    private var viewModel: CartVM!
    private var view: MockCartVC!
    private var firestoreManager: MockFirestoreManager!

    override func setUp() {
        super.setUp()
        view = .init()
        firestoreManager = .init()
        viewModel = .init(view: view,
                          firestoreManager: firestoreManager)
    }

    override func tearDown() { super.tearDown() }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        // Given
        XCTAssertEqual(view.invokedConfigureNavigationControllerCount, 0)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 0)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertEqual(view.invokedConfigureNavigationControllerCount, 1)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 1)
    }
    
    func test_viewWillAppear_InvokesRequiredMethods() {
        // Given
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 0)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 0)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
        // When
        viewModel.viewWillAppear()
        
        // Then
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 1)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
    }
    
    func test_removeProductFromCart_InvokesRequiredMethods() {
        
        XCTAssertEqual(firestoreManager.invokedRemoveProductFromCartCount, 0)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 0)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 0)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
        viewModel.removeProductFromCart(cartItem: MockData.mockCartItem)
        
        XCTAssertEqual(firestoreManager.invokedRemoveProductFromCartCount, 1)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 1)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
    }
    
    func test_increaseCountOfCartItem_InvokesRequiredMethods() {
        
        XCTAssertEqual(firestoreManager.invokedIncreaseCountOfCartItemCount, 0)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 0)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 0)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
        viewModel.increaseCountOfCartItem(cartItem: MockData.mockCartItem)
        
        XCTAssertEqual(firestoreManager.invokedIncreaseCountOfCartItemCount, 1)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 1)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
    }
    
    func test_decreaseCountOfCartItem_InvokesRequiredMethods() {
        
        XCTAssertEqual(firestoreManager.invokedDecreaseCountOfCartItemCount, 0)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 0)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 0)
        XCTAssertEqual(view.invokedReloadDataCount, 0)
        
        viewModel.decreaseCountOfCartItem(cartItem: MockData.mockCartItem)
        
        XCTAssertEqual(firestoreManager.invokedDecreaseCountOfCartItemCount, 1)
        XCTAssertEqual(firestoreManager.invokedGetProductsFromCartCount, 1)
        XCTAssertEqual(view.invokedReloadTotalPriceCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
    }
    
    
    
}
