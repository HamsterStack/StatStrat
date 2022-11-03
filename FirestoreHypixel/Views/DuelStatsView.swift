//
//  DuelStatsView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 09/08/2022.
//

import SwiftUI

struct DuelStatsView: View {
    @ObservedObject var vm : PlayerViewModel
    var body: some View {
        switch vm.state{
        case .success(let player):
            List{
                
                Section{
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
                
                
                
                
                
                
                
               
                
               
                
                Section("Duel Stats"){
                    let wins = player.stats.Duels?.wins ?? 0
                    let losses = player.stats.Duels?.losses ?? 0
                    let wlr = player.stats.Duels?.wlr ?? 0
                    
                    
                    
                    
                    TwoTextView(First: "Wins⚔️", Second: "\(wins)", Color: Color.blue)
                    TwoTextView(First: "Losses💀 ", Second: "\(losses)", Color: Color.blue)
                    TwoTextView(First: "Duel WLR⚔️", Second: "\(String(format: "%.2f", wlr))", Color: Color.blue)
                    TwoTextView(First: "Wins⚔️", Second: "\(wins)", Color: Color.blue)
                    TwoTextView(First: "Losses💀", Second: "\(losses)", Color: Color.blue)
                    TwoTextView(First: "WLR💀", Second: "\(String(format: "%.2f", wlr))", Color: Color.blue)
                    
                    
                }
                Section("Bridge Stats"){
                    let bridgeLosses = player.stats.Duels?.bridgeOverallLosses ?? 0
                    let bridgeWins = player.stats.Duels?.bridgeOverallWins ?? 0
                    let bridgeWlr = bridgeLosses == 0 ? Double(bridgeWins) : Double(bridgeWins) / Double(bridgeLosses)
                    
                    TwoTextView(First: "Wins⚔️", Second: "\(bridgeWins)", Color: Color.blue)
                    TwoTextView(First: "Losses💀 ", Second: "\(bridgeLosses)", Color: Color.blue)
                    TwoTextView(First: "WLR⚔️", Second: "\(String(format: "%.2f", bridgeWlr))", Color: Color.blue)
                    
                }
               
                
                
                
                
            }
            
            .padding(.vertical, -30) //removable we will see.
            
           
        default:
            EmptyView()
        }
    }
}
