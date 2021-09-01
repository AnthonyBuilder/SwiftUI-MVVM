//
//  Login.swift
//  Login
//
//  Created by Anthony on 25/08/21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var model: LoginViewModel
    
    init(model: LoginViewModel){
        self.model = model
    }
    
    var body: some View {
        Form {
            Section(footer: formFooter) {
                TextField("E-mail", text: model.bindings.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Senha", text: model.bindings.password)
            }
        }
        .navigationBarItems(trailing: submitButton)
        .navigationBarTitle("Identifique-se")
        .disabled(model.state.isLogginIn)
        .alert(isPresented: model.bindings.errorAlert) {
            Alert(
                title: Text("Erro ao fazer login"),
                message: Text("Verifique seu email ou senha e tente novamente.")
            )
        }
    }
    
    private var formFooter: some View {
        Text(model.state.footerMessage)
    }
    
    private var submitButton: some View {
        Button(action: model.login) {
            Text("Entrar")
        }.disabled(model.state.canSubmit == false)
    }

//    private var emailBinding: Binding<String> {
//        Binding(get: { self.email }, set: { value in self.email = value })
//    }
}

struct LoginViewState: Equatable {
    var email = ""
    var password = ""
    var isLogginIn = false
    var isShowingAlertError = false
}

extension LoginViewState {
    var canSubmit: Bool { email.isEmpty == false && password.isEmpty == false }
    var footerMessage: String { isLogginIn ? "Fazendo login..." : "" }
}

final class LoginViewModel: ObservableObject {
    @Published var state: LoginViewState
    
    var bindings: (email: Binding<String>, password: Binding<String>, errorAlert: Binding<Bool>) {
        (
            email: Binding(to: \.state.email, on: self),
            password: Binding(to: \.state.password, on: self),
            errorAlert: Binding(to: \.state.isShowingAlertError, on: self)
        )
    }
    
    init(initialState: LoginViewState) {
        state = initialState
    }
    
    func login() {
        state.isLogginIn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.state.isLogginIn = false
            self.state.isShowingAlertError = true
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView(model: .init(initialState: .init()))
        }
    }
}
