//
//  swiftui_mvvmTests.swift
//  swiftui-mvvmTests
//
//  Created by Anthony on 25/08/21.
//

import XCTest
@testable import swiftui_mvvm

class LoginTests: XCTestCase {
    
    private var viewModel: LoginViewModel! // Subject Under Test
    
    override func setUp() {
        super.setUp()
        viewModel = .init(initialState: .init())
    }
    
    func testDefaultInitialState() {
        XCTAssertEqual(
            viewModel.state, LoginViewState(
                email: "",
                password: "",
                isLogginIn: false,
                isShowingAlertError: false
            )
        )
        
        XCTAssertFalse(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
    }

    func testSuccesfulLoginFlow() {
        
    }
    
    func testUnsuccesfulLoginFlow() {
         XCTFail()
    }
}
