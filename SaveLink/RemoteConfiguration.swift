//
//  RemoteConfiguration.swift
//  SaveLink
//
//  Created by Danilo Osorio on 8/05/25.
//

import Foundation
import FirebaseRemoteConfig


final class RemoteConfiguration: ObservableObject {
     @Published var buttonTitle: String = ""
    
    var remoteConfig: RemoteConfig
    
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 30
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(["create_button_title": "Cargando..." as NSObject])
        buttonTitle = remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
    }
    
    func fetch() {
        remoteConfig.fetchAndActivate { [weak self] success, error in
            if let error = error {
                print("Error fetching remote config: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self?.buttonTitle = self?.remoteConfig.configValue(forKey: "create_button_title").stringValue ?? ""
            }
        }
    }
}
