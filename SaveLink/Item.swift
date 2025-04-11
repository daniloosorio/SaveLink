//
//  Item.swift
//  SaveLink
//
//  Created by Danilo Osorio on 10/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
