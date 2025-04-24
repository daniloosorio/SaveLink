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
        TabView {
            NavigationStack {
                VStack {
                    Text("Bienvenido \(authenticationViewModel.user?.email ?? "No hay usuario")")
                        .padding(.top, 8)
                    Spacer()
                    LinkView(linkViewModel: linkViewModel)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Home")
                .toolbar {
                    Button("Logout") {
                        authenticationViewModel.logout()
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                ProfileView(authenticationViewModel: authenticationViewModel)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Profile")
                    .toolbar {
                        Button("Logout") {
                            authenticationViewModel.logout()
                        }
                    }
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }

}

#Preview {
    HomeView(authenticationViewModel: AuthenticationViewModel())
}
