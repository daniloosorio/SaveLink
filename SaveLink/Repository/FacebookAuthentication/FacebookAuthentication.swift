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
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        loginManager.logIn(permissions: ["email"], from: nil) { loginManagerResult, error in
            if let error = error {
                print("❌ Error login with Facebook: \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            // Verificamos si el usuario canceló el login
            if let result = loginManagerResult, result.isCancelled {
                print("⚠️ Login cancelled by user.")
                let cancelError = NSError(domain: "FacebookLogin", code: 1, userInfo: [NSLocalizedDescriptionKey: "Login was cancelled"])
                completionBlock(.failure(cancelError))
                return
            }

            // Verificamos si el token está disponible
            guard let token = loginManagerResult?.token?.tokenString, !token.isEmpty else {
                print("❌ AccessToken is nil or empty")
                let tokenError = NSError(domain: "FacebookLogin", code: 2, userInfo: [NSLocalizedDescriptionKey: "AccessToken is missing"])
                completionBlock(.failure(tokenError))
                return
            }
            
            print("✅ Received Facebook AccessToken: \(token)")
            completionBlock(.success(token))
        }
    }
}

