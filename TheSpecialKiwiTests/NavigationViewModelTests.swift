//
//  NavigationViewModelTests.swift
//  TheSpecialKiwiTests
//
//  Created by Reyhan Ariq Syahalam on 21/08/24.
//

//import XCTest
//
//final class NavigationViewModelTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}


import XCTest
@testable import TheSpecialKiwi

class NavigationViewModelTests: XCTestCase {
    
    var viewModel: NavigationViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = NavigationViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testNavigateToGame() {
        viewModel.navigateToGame(.communication)
        XCTAssertEqual(viewModel.currentGame, .communication)
        
        viewModel.navigateToGame(.eyeContact)
        XCTAssertEqual(viewModel.currentGame, .eyeContact)
    }
    
    func testGoBack() {
        viewModel.navigateToGame(.informationGame)
        viewModel.goBack()
        XCTAssertNil(viewModel.currentGame)
    }
}
