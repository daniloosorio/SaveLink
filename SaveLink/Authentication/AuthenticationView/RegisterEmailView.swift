//
//  RegisterEmailView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import SwiftUI

struct RegisterEmailView: View {
    @State var authenticationViewModel : AuthenticationViewModel
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
                Text("Registrate para acceder")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top,2)
                    .padding(.bottom,2)
                TextField("Correo", text: $textFieldEmail)
                TextField("Contraseña", text:$textFieldPassword)
                Button("Registrame"){
                    authenticationViewModel.createNewUser(email: textFieldEmail,
                                                          password: textFieldPassword)
                }
                .padding(.top,18)
                .buttonStyle(.bordered)
                .tint(.gray)
                if let messageError = authenticationViewModel.messageError{
                    Text(messageError)
                        .bold()
                        .font(.body)
                        .foregroundStyle(.red)
                        .padding(.top,20)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal,64)
            Spacer()
        }
    }
}

#Preview {
    RegisterEmailView(authenticationViewModel: AuthenticationViewModel())
}
