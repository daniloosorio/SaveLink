//
//  AuthenticationFirebaseDataSource.swift
//  SaveLink
//
//  Created by Danilo Osorio on 14/04/25.
//

import Foundation
import FirebaseAuth


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
                print("Received Facebook AccessToken: \(accessToken)")

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
    
    func currentProvider() -> [LinkedAccount] {
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
        let linkedAccounts = currentUser.providerData.map { userInfo in
            LinkedAccount(rawValue: userInfo.providerID)
        }.compactMap{$0}
        return linkedAccounts
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
        facebookAuthentication.loginFacebook{ result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential) { (authDataResul, error) in
                    if let error = error {
                        print("Error linking a new user \(error.localizedDescription)")
                        completionBlock(false)
                    }
                    let email = authDataResul?.user.email ?? "No email"
                    print("new user linked: \(email)")
                    completionBlock(true)
                }
            case.failure(let error):
                print("Error linkin a new user \(error.localizedDescription)")
                completionBlock(false)
            }
        }
        
    }
    
    func getCurrentCredential() -> AuthCredential? {
        guard let providerId = currentProvider().last else {
            return nil
        }
        switch providerId {
        case .facebook:
            guard let accessToken = facebookAuthentication.getAccessToken() else {
                return nil
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            return credential
        case .emailAndPassword, .unknown:
            return nil
        
        }
    }
    
    func linkEmailAndPassword(email:String, password : String, completionBlock: @escaping(Bool)->Void){
        guard let credential = getCurrentCredential() else {
            print("error creatin credential")
            completionBlock(false)
            return
        }
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authDataResult, error in
            if let error = error {
                print("error reauthenticating user: \(error.localizedDescription)")
                completionBlock(false)
                return
            }
            
            let emailAndPasswordCredential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            Auth.auth().currentUser?.link(with: emailAndPasswordCredential, completion: { authDataResult, error in
                if let error = error {
                    print("error linking email and password: \(error.localizedDescription)")
                    completionBlock(false)
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print("new user linked with email \(email)")
                completionBlock(true)
                
            })
            
            
        })
    }
}
