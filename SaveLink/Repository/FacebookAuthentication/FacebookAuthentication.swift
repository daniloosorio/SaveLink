//
//  FacebookAuthentication.swift
//  SaveLink
//
//  Created by Danilo Osorio on 15/04/25.
//

import Foundation
import FacebookLogin

final class FacebookAuthentication {
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String,Error>) -> Void ){
        loginManager.logIn(permissions: ["email"],
                           from: nil) {loginManagerResult, error in
            if let error = error {
                print("Error login with Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let token = loginManagerResult?.token?.tokenString
            completionBlock(.success(token ?? "Empty Token"))
            
        }
    }
}
