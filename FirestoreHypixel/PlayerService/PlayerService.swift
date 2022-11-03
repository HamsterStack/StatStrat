//
//  PlayerService.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 31/07/2022.
//

import Foundation
struct PlayerService {
    static private var key : String = "cfa089c9-790f-4def-8b4f-32ace80a54a4"
    
    enum PlayerServiceError : Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    //risky
    
    
    
    
    
    
    
    func fetchUUID(username: String) async throws -> String {
        let url = URL(string: "https://api.mojang.com/users/profiles/minecraft/\(username)") ?? URL(string: "https://api.mojang.com/users/profiles/minecraft/")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else
        {
            throw PlayerServiceError.invalidStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(UUIDResponse.self, from: data)
        return decodedData.id
        
        
    }
    
    func fetchPlayer(uuid : String) async throws -> Player {
        
        let url = URL(string: "https://api.hypixel.net/player?key=\(PlayerService.key)&uuid=\(uuid)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else
        {
            
            throw PlayerServiceError.invalidStatusCode
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decodedData = try decoder.decode(PlayerStats.self, from: data)
        return decodedData.player
        
        
        
        
    }
    
    
}
