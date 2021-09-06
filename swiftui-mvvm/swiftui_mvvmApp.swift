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
                    service: EmptyLoginService(),
                    loginDidSucceded: {}
                )
            )
        }
    }
}
