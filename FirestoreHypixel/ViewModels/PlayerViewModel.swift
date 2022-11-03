//
//  PlayerViewModel.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 31/07/2022.
//
import FirebaseFirestore
import Foundation
import SwiftUI
@MainActor
class PlayerViewModel: ObservableObject{
    
    enum PlayerState {
        case na
        case loading
        case success(data: Player)
        case failed(error : Error)
        
        
    }
    
   
    var db = Firestore.firestore()
    @Published   var state: PlayerState = .na
    
    
    private let service: PlayerService
    
    init(service: PlayerService)
    {
        self.service = service
        
    }
    
    
    
    
    
    
    
    
    func setupPlayer() {
        switch state{
        case .success(var player):
            let docRef = db.collection("players").document(player.displayname)
            docRef.getDocument {document, error in
                if let document = document, document.exists {
                    
                    
                    print("document exists")
                    player.todayFinalKills = document["todayFinalKills"] as? Int
                    player.todayFinalDeaths = document["todayFinalDeaths"] as? Int
                    player.todayBedwarsWins = document["todayBedwarsWins"] as? Int
                    player.todayBedwarsLosses = document["todayBedwarsLosses"] as? Int
                    player.todayTntRunWins = document["todayTntRunWins"] as? Int
                    player.todayTntRunLosses = document["todayTntRunLosses"] as? Int
                    let registerDate = (document["registerDate"] as? Timestamp)?.dateValue() ?? Date()
                    let components = Calendar.current.dateComponents([.minute, .hour], from: registerDate , to: Date.now)
                    print("difference is \(components.hour ?? 0) hours and \(components.minute ?? 0) minutes.")
                    print("resets in \(23 - (components.hour ?? 0))hours and \(60 - (components.minute ?? 0))")
                    player.hoursAway = 23 - (components.hour ?? 0)
                    player.minutesAway = 60 - (components.minute ?? 0)
                    
                    
                    self.state = .success(data: player)
                    
                    print(player.todayFinalKills ?? 0)
                    print(player.stats.Bedwars?.final_kills_bedwars ?? 0)
                    print(player.todayBedwarsLosses ?? 0)
                    print(player.stats.Bedwars?.losses_bedwars ?? 0)
                }
                else{
                    let stats : [String : Int] = [
                        
                        "todayFinalKills": player.stats.Bedwars?.final_kills_bedwars ?? 0,
                        "todayFinalDeaths" : player.stats.Bedwars?.final_deaths_bedwars ?? 0,
                        "todayBedwarsWins" : player.stats.Bedwars?.wins_bedwars ?? 0,
                        "todayBedwarsLosses" : player.stats.Bedwars?.losses_bedwars ?? 0,
                        "todayTntRunLosses" : player.stats.TNTGames?.deaths_tntrun ?? 0,
                        "todayTntRunWins" : player.achievements?.tntgames_tnt_run_wins ?? 0,
                        
                        
                    
                           ]
                    self.db.newPlayerDocument(data: stats, username: player.displayname, uuid: player.uuid)
                }
            }
            
            
        default:
            print("default")
        }
        
        
    
    }
    
    
    
    
    func getPlayer(username: String) async {
        state = .loading
        
        do{
            let uuid = try await service.fetchUUID(username: username)
            let player = try await service.fetchPlayer(uuid: uuid)
            
            state = .success(data: player)
        }
        catch{
            print(error)
            state = .failed(error: error)
        }
        
        
        
        
    }
    
    
    
    
}
