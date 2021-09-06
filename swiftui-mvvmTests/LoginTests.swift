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
    private var service: LoginServiceMock!
    private var didCallLoginDidSucceded: Bool!
    
    override func setUp() {
        super.setUp()
        didCallLoginDidSucceded = false
        service = .init()
        viewModel = .init(
            initialState: .init(),
            service: service,
            loginDidSucceded: { [weak self] in
                self?.didCallLoginDidSucceded = true
            }
        )
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
        viewModel.bindings.email.wrappedValue = "anthonyj2017@icloud.com"
        viewModel.bindings.password.wrappedValue = "x"
        
        XCTAssert(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
        
        viewModel.login()
    
        XCTAssertEqual(
            viewModel.state, LoginViewState(
                email: "anthonyj2017@icloud.com",
                password: "x",
                isLogginIn: true,
                isShowingAlertError: false
            )
        )
        
        service.completion?(nil)
        XCTAssert(didCallLoginDidSucceded)
        
        XCTAssertFalse(viewModel.state.canSubmit)
        XCTAssertEqual(viewModel.state.footerMessage, LoginViewState.isLogginInFooter)
    }
    
    func testUnsuccesfulLoginFlow() {
         XCTFail()
    }
}

private final class LoginServiceMock: LoginService {
    var lastRecivedEmail: String?
    var lastRecivedPassword: String?
    var completion: ((Error?) -> Void)?
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        lastRecivedEmail = email
        lastRecivedPassword = password
        self.completion = completion
    }
}
