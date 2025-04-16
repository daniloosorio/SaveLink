//
//  AuthenticationFirebaseDataSource.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import Foundation
import FirebaseAuth

struct User {
    let email:String
}

final class AuthenticationFirebaseDataSource {
    private var facebookAuthentication = FacebookAuthentication()
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else { return nil }
        return .init(email: email)
    }
    
    func createNewUser(email:String,password:String,completionBlock:@escaping (Result<User,Error>)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = AuthDataResult?.user.email ?? "No email"
            print("New user create with info: \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func login(email: String, password: String, completionBlock:@escaping (Result<User,Error>)->Void){
        Auth.auth().signIn(withEmail: email, password: password){ authDataResult, error in
            if let error = error {
                print("Error login user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("user login with info \(email)")
            completionBlock(.success(.init(email: email)))
        }
    }
    
    func loginWithFacebook(completionBlock: @escaping (Result<User,Error>)->Void){
        facebookAuthentication.loginFacebook{ result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential){ AuthDataResult, error in
                    if let error = error {
                        print("Error creating a new user \(error.localizedDescription)")
                        completionBlock(.failure(error))
                        return
                    }
                    let email = AuthDataResult?.user.email ?? "No email"
                    print("New User create with info \(email)")
                    completionBlock(.success(.init(email: email)))
                }
            case .failure(let error):
                print("Error signing in facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
    }
}
