//
//  UserDefaultExtensions.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 07/08/2022.
//

import Foundation
extension UserDefaults{
    static func getUsers() -> [SavedPlayer]? {
        if let data = UserDefaults.standard.data(forKey: "users"){
            let decoder = JSONDecoder()
            
            let players = try? decoder.decode([SavedPlayer].self, from: data)
            return players
        }
        return [SavedPlayer]()
    }
}
