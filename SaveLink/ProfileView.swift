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
                }).disabled(<#T##disabled: Bool##Bool#>)
                Button(action: {
                    print("Vincular facebook")
                }, label: {
                    Label {
                        Text("Vincula facebook")
                    } icon: {
                        Image("face").resizable().frame(width: 25,height: 25)
                    }
                })
            } header: {
                Text("Vincula otras cuentas a la sesion actual")
            }
        }
    }
}

#Preview {
    ProfileView(authenticationViewModel:AuthenticationViewModel())
}
