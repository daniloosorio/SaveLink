//
//  ProfileView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 16/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State var authenticationViewModel: AuthenticationViewModel
    @State var expandVerificationWithEmailForm: Bool = false
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    var body: some View {
        Form{
            Section {
                Button(action: {
                    expandVerificationWithEmailForm.toggle()
                    print("vincular email y password")
                }, label: {
                    Label("Vincula Email", systemImage: "envelope.fill")
                }).disabled(authenticationViewModel.isEmailAndPasswordLinked())
                if(expandVerificationWithEmailForm){
                    Group{
                        Text("Vincula correo electronico")
                            .tint(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.top,2)
                            .padding(.bottom,2)
                        TextField("Correo", text: $textFieldEmail)
                        TextField("Contraseña", text:$textFieldPassword)
                        Button("Aceptar"){
                            authenticationViewModel.linkEmailAndPassword(email: textFieldEmail, password: textFieldPassword)
                        }
                        .padding(.top,18)
                        .buttonStyle(.bordered)
                        .tint(.gray)
                        
                        if let messageError = authenticationViewModel.messageError{
                            Text(messageError)
                                .foregroundColor(.red)
                        }
                    }
                }
                Button(action: {
                    print("Vincular facebook")
                    authenticationViewModel.linkFacebook()
                }, label: {
                    Label {
                        Text("Vincula facebook")
                    } icon: {
                        Image("face").resizable().frame(width: 25,height: 25)
                    }
                }).disabled(authenticationViewModel.isFacebookLinked())
            } header: {
                Text("Vincula otras cuentas a la sesion actual")
            }
        }.task {
            authenticationViewModel.getCurrentProvider()
        }.alert(authenticationViewModel.isAccountLinked ? "cuenta vinculada!" : "Error",
                isPresented: $authenticationViewModel.showAlert,
                actions: {
            Button("Aceptar"){
                print("dismiss alert")
                if(authenticationViewModel.isAccountLinked){
                    expandVerificationWithEmailForm = false
                }
            }},
                message: {
            Text(authenticationViewModel.isAccountLinked ?  "✅ Se ha vinculado la cuenta" : "❌ No se ha podido vincular la cuenta")
        })
    }
}

#Preview {
    ProfileView(authenticationViewModel:AuthenticationViewModel())
}
