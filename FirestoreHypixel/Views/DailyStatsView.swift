//
//  DailyStatsView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 05/08/2022.
//

import SwiftUI

struct DailyStatsView: View {
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
                    let fkdr = String(format: "%.2f", player.dailyFkdr ?? 0)
                    Text("Daily Final Kills \(player.dailyFinals ?? 0)")
                    Text("Daily Final Deaths \(player.dailyFinalDeaths ?? 0)")
                    Text("Daily FKDR \(fkdr)")
                    Text("Daily Wins \(player.dailyBedwarsWins ?? 0)")
                    Text("Daily Losses \(player.dailyBedwarsLosses ?? 0)")
                    
                }
                
            }
            
            
            
        default:
            EmptyView()
        }
    }
}

struct DailyStatsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStatsView(vm: PlayerViewModel(service: PlayerService()))
    }
}
