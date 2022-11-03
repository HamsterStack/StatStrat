//
//  DailyView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var vm: PlayerViewModel
    @State private var helpShowing = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        switch vm.state{
        case .success(let player):
            List{
                
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
               
                //Text("\(player.todayFinalKills ?? 0)")
                Section{
                    NavigationLink{
                        DailyStatsView(vm: vm)
                            .navigationTitle("Daily Bedwars")
                    } label: {
                        Button("Daily Bedwars"){}
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            
                    }
                    NavigationLink{
                        DailyTNTRunStatsView(vm: vm)
                            .navigationTitle("Daily TNT Run")
                    } label: {
                        Button("Daily TNT Run"){}
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            
                            
                    }
                    
                    NavigationLink{
                        DailySkywarsStatsView(vm: vm)
                            .navigationTitle("Daily Skywars")
                    } label: {
                        Button("Daily Skywars"){}
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            
                    }
                    NavigationLink{
                        DailyDuelsView(vm: vm)
                            .navigationTitle("Daily Duels")
                    } label: {
                        Button("Daily Duels"){}
                            .foregroundColor(colorScheme == .light ? .black : .white)
                            
                    }
                   
                    
                }
                
                
                
                
                
                
                
                
            }
            .toolbar{
                ToolbarItem(placement : .navigationBarTrailing){
                    Button(action: { helpShowing.toggle() } , label:  {
                        Image(systemName: "questionmark.circle")
                    })
                    .sheet(isPresented: $helpShowing){
                        DailyHelpView(helpShowing: $helpShowing)
                    }
                    
                }
                
            }
            
            
        default:
            EmptyView()
        }
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(vm: PlayerViewModel(service: PlayerService()))
    }
}
