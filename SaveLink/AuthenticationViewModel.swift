//
//  AuthenticationViewModel.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import Foundation

@Observable
final class AuthenticationViewModel {
    var user: User?
    var messageError: String?
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        DispatchQueue.main.async {
               self.getCurrentUser()
           }
    }
    
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String){
        authenticationRepository.createNewUser(email: email, password: password, completionBlock: {[weak self] result in
            switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.messageError = error.localizedDescription
                
            }
            
        })
    }
}
