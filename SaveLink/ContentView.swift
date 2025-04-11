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


struct ContentView: View {
    @State private var authenticationSheetView: AuthenticationSheetView?
    
    var body: some View{
        VStack {
            Image("usuario")
                .resizable()
                .frame(width: 200,height: 200)
            VStack {
                Button {
                    authenticationSheetView = .Login
                    print("Login")
                } label: {
                    Label("Entra con Email", systemImage: "envelope.fill")
                }.tint(.black)
                    .controlSize(.large)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .padding(.top, 60)
                Spacer()
                HStack {
                    Button {
                        authenticationSheetView = .Register
                        print("Registro")
                    } label: {
                        Text("¿No tienes una cuenta?")
                        Text("Registrate")
                            .underline()
                    }.tint(.black)
                }
            }
        }
        .sheet(item: $authenticationSheetView, content: { sheet in
            switch sheet {
            case .Register:
                Text("Registro")
            case .Login:
                Text("Login")
            }
        })
    }
}

#Preview {
    ContentView()
}
