//
//  HomeView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 15/04/25.
//

import SwiftUI

struct HomeView: View {
    @State var authenticationViewModel: AuthenticationViewModel
    var body: some View {
        NavigationView(content: {
            VStack{
                Text("Bienvenido\(authenticationViewModel.user?.email ?? "No hay usuario")")
                    .padding(.top,32)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar(content: {
                Button("Logout"){
                    authenticationViewModel.logout()
                }
            })
        })
    }
}

#Preview {
    HomeView(authenticationViewModel: AuthenticationViewModel())
}
