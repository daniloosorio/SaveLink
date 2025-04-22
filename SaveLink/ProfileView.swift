//
//  ProfileView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 16/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        Form{
            Section {
                Button(action: {
                    print("vincular email y password")
                }, label: {
                    Label("Vincula Email", systemImage: "envelope.fill")
                }).disabled(authenticationViewModel.isEmailAndPasswordLinked())
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
            Button("Aceptar"){print("dismiss alert")}},
                message: {
            Text(authenticationViewModel.isAccountLinked ?  "✅ Se ha vinculado la cuenta" : "❌ No se ha podido vincular la cuenta")
        })
    }
}

#Preview {
    ProfileView(authenticationViewModel:AuthenticationViewModel())
}
