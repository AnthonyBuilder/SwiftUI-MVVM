//
//  Login.swift
//  Login
//
//  Created by Anthony on 25/08/21.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLogginIn = false
    @State private var isShowingAlertError = false

    var body: some View {
        Form {
            Section(footer: formFooter) {
                TextField("E-mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Senha", text: $password)
            }
        }
        .navigationBarItems(trailing: submitButton)
        .navigationBarTitle("Identifique-se")
        .disabled(isLogginIn)
        .alert(isPresented: $isShowingAlertError) {
            Alert(title: Text("Erro ao fazer login"), message: Text("Verifique seu email ou senha e tente novamente."))
        }
    }
    
    private var formFooter: some View {
        Group {
            if isLogginIn {
                Text("Fazendo login...")
            }
        }
    }
    
    private var submitButton: some View {
        Button(action: login) {
            Text("Entrar")
        }.disabled(email.isEmpty || password.isEmpty)
    }
    
    private func login() {
        isLogginIn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            isLogginIn = false
            isShowingAlertError = true
        }
    }
    
//    private var emailBinding: Binding<String> {
//        Binding(get: { self.email }, set: { value in self.email = value })
//    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
