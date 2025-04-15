//
//  AuthenticationRepository.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDataSource: AuthenticationFirebaseDataSource
    
    init(authenticationFirebaseDataSource: AuthenticationFirebaseDataSource = AuthenticationFirebaseDataSource()) {
        self.authenticationFirebaseDataSource = authenticationFirebaseDataSource
    }
    
    func getCurrentUser() -> User? {
        authenticationFirebaseDataSource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void){
        authenticationFirebaseDataSource.createNewUser(email: email,
                                                       password: password,
                                                       completionBlock: completionBlock)
    }
}
