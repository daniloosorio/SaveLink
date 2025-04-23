//
//  HomeView.swift
//  SaveLink
//
//  Created by Danilo Osorio on 15/04/25.
//

import SwiftUI

struct HomeView: View {
    @State var authenticationViewModel: AuthenticationViewModel
    @State var linkViewModel: LinkViewModel = LinkViewModel()
    
    var body: some View {
        NavigationView(content: {
            TabView{
                VStack{
                    Text("Bienvenido\(authenticationViewModel.user?.email ?? "No hay usuario")")
                        .padding(.top,8)
                    Spacer()
                    LinkView(linkViewModel:linkViewModel)
                }.tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                ProfileView(authenticationViewModel:authenticationViewModel)
                    .tabItem{
                        Label("Profile", systemImage: "person.fill")
                    }
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
