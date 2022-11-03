//
//  Player.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 31/07/2022.
//

import Foundation
struct UUIDResponse: Codable, Hashable{
    var id: String
}



struct PlayerStats : Codable, Hashable{
    //so this is the first part of the json object which basically contains a player
    var player: Player
}

struct Player : Codable, Hashable, Equatable{
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.uuid == rhs.uuid
    }
    var prefix: String?
    
    // so a player contains many objects, like stats, achievements, etc
    var stats: Stats
    var achievements: Achievements?
    var displayname: String
    var uuid : String
    var networkExp: Int?
    var karma: Int?
    var newPackageRank : String? //this could be MVP_PLUS
    var rankPlusColor : String? //this could be LIGHT_PURPLE
    var monthlyPackageRank: String?
    var firstLogin : Date?
    
    //daily statistics for the player.
    
    var todayFinalKills : Int?
    var todayBedwarsLosses : Int?
    var todayBedwarsWins: Int?
    var todayFinalDeaths: Int?
    var todayTntRunWins: Int?
    var todayTntRunLosses: Int?
    var todaySkyWarsWins: Int?
    var todaySkyWarsLosses: Int?
    var todaySkywarsKills: Int?
    var todaySkywarsDeaths: Int?
    var todayBridgeWins: Int?
    var todayBridgeLosses: Int?
    var todayDuelWins: Int?
    var todayDuelLosses: Int?
    var isNew: Bool? = false //players are new by default
    //var registerDate: Date?
    var hoursAway: Int?
    var minutesAway: Int?
    
    var lastLogin: Date?
    var lastLogout: Date?
    
    
    //
    
    var dailyFinals: Int? {
        (stats.Bedwars?.final_kills_bedwars ?? 0) - (todayFinalKills ?? 0)
    }
    var dailyFinalDeaths: Int? {
        (stats.Bedwars?.final_deaths_bedwars ?? 0) - (todayFinalDeaths ?? 0)
    }
    var dailyFkdr: Double? {
        if dailyFinalDeaths == 0{
            return Double(dailyFinals ?? 0)
        }
        return Double(dailyFinals ?? 0) / Double(dailyFinalDeaths ?? 0)
    }
    var dailyBedwarsWins: Int? {
        (stats.Bedwars?.wins_bedwars ?? 0) - (todayBedwarsWins ?? 0)
    }
    var dailyBedwarsLosses: Int?{
        (stats.Bedwars?.losses_bedwars ?? 0) - (todayBedwarsLosses ?? 0)
    }
    var dailyTNTRunWins: Int? {
        (achievements?.tntgames_tnt_run_wins ?? 0) - (todayTntRunWins ?? 0)
    }
    var dailyTNTRunLosses: Int? {
        (stats.TNTGames?.deaths_tntrun ?? 0) - (todayTntRunLosses ?? 0)
    }
    var dailySkywarsWins: Int? {
        (stats.SkyWars?.wins ?? 0 ) - (todaySkyWarsWins ?? 0)
    }
    var dailySkywarsLosses: Int? {
        (stats.SkyWars?.losses ?? 0 ) - (todaySkyWarsLosses ?? 0)
    }
    var dailySkywarsKills: Int? {
        (stats.SkyWars?.kills ?? 0 ) - (todaySkywarsKills ?? 0)
    }
    var dailySkywarsDeaths: Int? {
        (stats.SkyWars?.deaths ?? 0 ) - (todaySkywarsDeaths ?? 0)
    }
    
    var dailyBridgeWins: Int?{
        (stats.Duels?.bridgeOverallWins ?? 0) - (todayBridgeWins ?? 0)
    }
    var dailyBridgeLosses: Int?{
        (stats.Duels?.bridgeOverallLosses ?? 0) - (todayBridgeLosses ?? 0)
    }
    var dailyDuelWins: Int?{
        (stats.Duels?.wins ?? 0) - (todayDuelWins ?? 0)
    }
    var dailyDuelLosses: Int?{
        (stats.Duels?.losses ?? 0) - (todayDuelLosses ?? 0)
    }


    
    
    
    var networkLevel: Double{
        (sqrt(Double(networkExp ?? 0) + 15312.5) - (125 / sqrt(2.0))) / (25 * sqrt(2.0))
    }
    
    //and we have two nested structs, stats and achievements.
    struct Stats : Codable, Hashable{
        var TNTGames : tntgames? //was optional
        var Bedwars: Bedwars?
        var SkyWars: SkyWars?
        var Duels: Duels?
    }
    
    struct Achievements : Codable, Hashable{
        var bedwars_beds: Int?
        var tntgames_tnt_run_wins : Int?
        var bedwars_level: Int?
        var duels_bridge_wins: Int?
        var duels_bridge_doubles_wins: Int?
        var duels_bridge_threes_wins : Int?
        var duels_bridge_teams_wins: Int?
        var bridgeOverallWins: Int{
            (duels_bridge_wins ?? 0) + (duels_bridge_doubles_wins ?? 0) + (duels_bridge_threes_wins ?? 0) + (duels_bridge_teams_wins ?? 0)
        }
        
        
        // others
    }
    
}

//i could nest this too but i kinda wanna organize it
struct SkyWars: Codable, Hashable{
    var wins : Int?
    var losses: Int?
    var kills: Int?
    var deaths: Int?
    var fkdr: Double? {
        if(deaths==0){
            return Double(kills ?? 00)
        }
        return Double(kills ?? 0)/Double(deaths ?? 0) 
    }
    var wlr: Double?{
        if(losses==0) {
            return Double(wins ?? 0)
        }
        return Double(wins ?? 0) / Double(losses ?? 0)
    }
}
struct tntgames : Codable, Hashable
{
    var deaths_tntrun : Int?
}

struct Bedwars: Codable, Hashable{
    
    var favourites_2: String?
    var playerShop: [String] {
        
        favourites_2?.components(separatedBy: [","]) ?? [""]
    }
    
    
    var final_deaths_bedwars: Int?
    var final_kills_bedwars: Int?
    var wins_bedwars: Int?
    var beds_lost_bedwars: Int?
    var void_deaths_bedwars : Int?
    var losses_bedwars : Int?
    var fkdr: Double?{
        if final_deaths_bedwars == 0{
            return Double(final_kills_bedwars ?? 0)
        }
        return Double(final_kills_bedwars ?? 0) / Double(final_deaths_bedwars ?? 0)
    }
    var wlr: Double? {
        if losses_bedwars == 0{
            return Double(wins_bedwars ?? 0)
        }
        return Double(wins_bedwars ?? 0 ) / Double(losses_bedwars ?? 0)
    }
    
    
}
struct Duels: Codable, Hashable {
    var bridge_duel_losses : Int?
    var bridge_doubles_losses: Int?
    var bridge_threes_losses: Int?
    var bridge_four_losses: Int?
    
    var bridge_duel_wins: Int?
    var bridge_doubles_wins: Int?
    var bridge_threes_wins: Int?
    var bridge_four_wins: Int?
    
    var bridgeOverallWins: Int?{
        (bridge_duel_wins ?? 0) + (bridge_doubles_wins ?? 0) + (bridge_threes_wins ?? 0) + (bridge_four_wins ?? 0)
    }
    
    var bridgeOverallLosses: Int?{
        (bridge_duel_losses ?? 0) + (bridge_doubles_losses ?? 0)  + (bridge_threes_losses ?? 0) + (bridge_four_losses ?? 0)
    }
    var goals: Int?
    var wins: Int?
    var losses: Int?
    var wlr: Double?{
        if losses == 0{
            return Double(wins ?? 0)
        }
        return Double(wins ?? 0) / Double(losses ?? 0)
    }
    var bridgeWlr : Double{
        if bridgeOverallLosses == 0{
            return Double(bridgeOverallWins ?? 0)
        }
        return Double(bridgeOverallWins ?? 0 ) / Double(bridgeOverallLosses ?? 0)
    }
    
}
