//
//  SavedPlayer.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 07/08/2022.
//

import Foundation
struct SavedPlayer: Codable, Equatable{
    
    let displayName : String
    let uuid : String
    let rankColor : String
    let rank: String
    let mvpPlusPlus: Bool
}
