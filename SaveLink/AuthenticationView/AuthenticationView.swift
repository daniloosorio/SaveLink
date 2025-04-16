//
//  ContentView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 10/04/25.
//

import SwiftUI
import SwiftData
import Firebase

enum AuthenticationSheetView: String, Identifiable {
    case Register
    case Login
    var id: String { self.rawValue }
}


struct AuthenticationView: View {
    @State var authenticationViewModel :AuthenticationViewModel
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View{
        VStack {
            Image("usuario")
                .resizable()
                .frame(width: 200, height: 200)
                .background(Color.white)
                .cornerRadius(20)
            VStack {
                Button {
                    authenticationSheetView = .Login
                    print("Login")
                } label: {
                    Label("Entra con Email", systemImage: "envelope.fill").foregroundColor(.primary)
                }.tint(.gray)
                    .controlSize(.large)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.top, 60)
                
                Button {
                    authenticationViewModel.loginWithFacebook()
                    print("Login")
                } label: {
                    Label {
                        Text("Entra con Facebook")
                    } icon: {
                        Image("face").resizable().frame(width: 25,height: 25)
                    }
                    .foregroundColor(.primary)
                }.tint(.blue)
                    .controlSize(.large)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.top, 15)
                Spacer()
                HStack {
                    Button {
                        authenticationSheetView = .Register
                        print("Registro")
                    } label: {
                        Text("¿No tienes una cuenta?")
                        Text("Registrate")
                            .underline()
                    }.tint(.primary)
                }
            }
        }
        .sheet(item: $authenticationSheetView, content: { sheet in
            switch sheet {
            case .Register:
                RegisterEmailView(authenticationViewModel:authenticationViewModel)
            case .Login:
                LoginEmailView(authenticationViewModel:authenticationViewModel)
            }
        })
    }
}

#Preview {
    AuthenticationView(authenticationViewModel: AuthenticationViewModel())
}
