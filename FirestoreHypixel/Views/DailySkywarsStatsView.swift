//
//  DailySkywarsStatsView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 09/08/2022.
//

import SwiftUI

struct DailySkywarsStatsView: View {
    @ObservedObject var vm: PlayerViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        switch vm.state{
        case .success(let player):
           
            let hours = player.hoursAway ?? 0
            let minutes = player.minutesAway ?? 0
            
            
            
            List{
                Section{
                    if (minutes < 0 || hours  < 0) {
                        Text("Your daily stats will reset soon.")
                    }
                    else if minutes != 1{
                        Text("Your daily stats reset in \(hours) hours and \(minutes) minutes.")
                    }
                    else{
                        Text("Your daily stats reset in \(hours) hours and \(minutes) minute.")
                    }
                    
                    
                    VStack{
                        RankTextView(username: player.displayname, rankColor: player.rankPlusColor ?? "BLACK", rank: player.newPackageRank ?? "", mvpPlusPlus: player.monthlyPackageRank == "SUPERSTAR" ? true : false)
                        
                        let url = URL(string: "https://crafatar.com/renders/body/\(player.uuid)")
                        AsyncImage(url: url) { image in
                            image
                            .center()
                        } placeholder: {
                            ProgressView()
                        }
                        
                    }
                }
             
                .listRowSeparator(.hidden)
               
               
                    
                Section{
                    
                    Text("Daily Skywars Wins \(player.dailySkywarsWins ?? 0)")
                    Text("Daily Skywars Losses \(player.dailySkywarsLosses ?? 0)")
                    Text("Daily Skywars Kills \(player.dailySkywarsKills ?? 0)")
                    Text("Daily Skywars Deaths \(player.dailySkywarsDeaths ?? 0)")
                    
                }
                
            }
          
            
            
        default:
            EmptyView()
        }
    }
}


