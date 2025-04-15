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
}
