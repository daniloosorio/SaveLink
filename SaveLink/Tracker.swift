//
//  Tracker.swift
//  SaveLink
//
//  Created by Danilo Osorio on 5/05/25.
//

import Foundation
import FirebaseAnalytics

final class Tracker {
    static func trackerCreateLinkEvent(url:String){
        Analytics.logEvent("CreateLinkEvent", parameters: ["url":url])
    }
    
    static func trackerSaveLinkEvent(){
        Analytics.logEvent("SaveLinkEvent",parameters: nil)
    }
    
    static func trackErrorSaveLinkEvent(error: String){
        Analytics.logEvent("ErrorSaveLinkEvent", parameters: ["error":error])
    }
}
