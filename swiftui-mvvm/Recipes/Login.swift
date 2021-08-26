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

    
    var body: some View {
        Form {
            TextField("E-mail", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            SecureField("Senha", text: $password)
        }.navigationBarItems(trailing: submitButton)
        .navigationBarTitle("Identifique-se")
    }
    
    private var submitButton: some View {
        Button(action: login) {
            Text("Entrar")
        }.disabled(email.isEmpty || password.isEmpty)
    }
    
    private func login() {
        // TODO: implement
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
