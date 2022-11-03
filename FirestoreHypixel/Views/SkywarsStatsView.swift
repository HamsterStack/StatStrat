//
//  SkywarsStatsView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 09/08/2022.
//

import SwiftUI

struct SkywarsStatsView: View {
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
                
                
                
                
                
                
                
               
                
               
                
                Section{
                    let kills = player.stats.SkyWars?.kills ?? 0
                    let deaths = player.stats.SkyWars?.deaths ?? 0
                    let fkdr = player.stats.SkyWars?.fkdr ?? 0
                    let wins = player.stats.SkyWars?.wins ?? 0
                    let losses = player.stats.SkyWars?.losses ?? 0
                    let wlr = player.stats.SkyWars?.wlr ?? 0
                    
                    
                    
                    TwoTextView(First: "Kills⚔️", Second: "\(kills)", Color: Color.blue)
                    TwoTextView(First: "Deaths💀 ", Second: "\(deaths)", Color: Color.blue)
                    TwoTextView(First: "FKDR⚔️", Second: "\(String(format: "%.2f", fkdr))", Color: Color.blue)
                    TwoTextView(First: "Wins⚔️", Second: "\(wins)", Color: Color.blue)
                    TwoTextView(First: "Losses💀", Second: "\(losses)", Color: Color.blue)
                    TwoTextView(First: "WLR💀", Second: "\(String(format: "%.2f", wlr))", Color: Color.blue)
                    
                    
                }
               
                
                
                
                
            }
            
            .padding(.vertical, -30) //removable we will see.
            
           
        default:
            EmptyView()
        }
    }
}


