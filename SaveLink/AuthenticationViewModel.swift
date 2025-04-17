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
    var linkedAccount : [LinkedAccount] = []
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
    
    func login(email: String, password: String){
        authenticationRepository.login(email: email, password: password, completionBlock: {[weak self] result in
            switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.messageError = error.localizedDescription
                
            }
            
        })
    }
    func loginWithFacebook(){
        authenticationRepository.loginFacebook(completionBlock: {[weak self] result in
            switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.messageError = error.localizedDescription
                
            }
            
        })
    }
    
    
    func logout(){
        do {
            try authenticationRepository.logout()
            self.user = nil
        }catch{
            print("Error logout")
            
        }
    }
    
    func getCurrentProvider() {
        linkedAccount = authenticationRepository.getCurrentProvider()
        print("user provider \(linkedAccount)")
    }
    
    func isEmailAndPasswordLinked() ->Bool {
        linkedAccount.contains(where: {$0.rawValue == "password"})
    }
    func isFacebookLinked() ->Bool {
        linkedAccount.contains(where: {$0.rawValue == "facebook.com"})
    }
}
