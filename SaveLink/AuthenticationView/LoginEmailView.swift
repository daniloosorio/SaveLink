//
//  LoginEmailView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import SwiftUI

struct LoginEmailView: View {
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        VStack {
            DismissView().padding(.top)
            Group {
                Text("Bienvenido a")
                Text("🔥Firebase App")
                    .bold()
                    .underline()
            }
            .padding(.horizontal,8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            Group{
                Text("Logueate de nuevo para acceder")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top,2)
                    .padding(.bottom,2)
                TextField("Correo", text: $textFieldEmail)
                TextField("Contraseña", text:$textFieldPassword)
                Button("Iniciar sesión"){
                    print("login")
                }
                .padding(.top,18)
                .buttonStyle(.bordered)
                .tint(.gray)
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal,64)
            Spacer()
        }
    }
}

#Preview {
    LoginEmailView()
}
