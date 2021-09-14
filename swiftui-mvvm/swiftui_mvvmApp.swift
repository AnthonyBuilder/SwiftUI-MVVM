//
//  swiftui_mvvmApp.swift
//  swiftui-mvvm
//
//  Created by Anthony on 25/08/21.
//

import SwiftUI

@main
struct swiftui_mvvmApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(
                model: .init(
                    initialState: .init(),
                    service: FailWithDelayLoginService()
                )
            )
        }
    }
}


class FailWithDelayLoginService: LoginService {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            completion(NSError(domain: "", code: 1, userInfo: nil))
        }
    }
}
