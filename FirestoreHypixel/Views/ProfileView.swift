//
//  ProfileView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI






struct ProfileView: View {
    @ObservedObject var vm : PlayerViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
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
                    
                    let level = player.networkLevel
                    let formattedLevel = String(format: "%.2f", level)
                    
                   
                   
                    TwoTextView(First: "Hypixel Level", Second: "\(formattedLevel)", Color: Color.mint)
                    TwoTextView(First: "Hypixel EXP", Second: "\(player.networkExp ?? 0)", Color: Color.mint)
                    
                    
                    
                    
                    
                    
                }
                
                
                
                NavigationLink{
                    BedwarsStatsView(vm: vm)
                        .navigationTitle("Bedwars Stats")
                } label: {
                    Text("Bedwars Stats")
                }
                NavigationLink{
                    SkywarsStatsView(vm: vm)
                        .navigationTitle("Skywars Stats")
                } label: {
                    Text("Skywars Stats")
                }
                NavigationLink{
                    DuelStatsView(vm: vm)
                } label: {
                    Text("Duel Stats")
                }
               
                Section("Status"){
                    if(player.lastLogin ?? Date.now > player.lastLogout ?? Date.now)
                    {
                        TwoTextView(First: "Status", Second: "Online", Color: .green)
                    }
                    else{
                        TwoTextView(First: "Status", Second: "Offline", Color: .red)
                    }
                    
                    TwoTextView(First: "First Login", Second: player.firstLogin?.formatted() ?? Date.now.formatted(), Color: .green)
                    if player.lastLogin != nil{
                        TwoTextView(First: "Last Login", Second: player.lastLogin?.formatted() ?? Date.now.formatted(), Color: .green)
                    }
                    if player.lastLogout != nil{
                        TwoTextView(First: "Last Logout", Second: player.lastLogin?.formatted() ?? Date.now.formatted(), Color: .green)
                    }
                        
                }
                
                
                
            }
            
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            //.padding(.vertical, -30) removable we will see.
            
            
           
        default:
            EmptyView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: PlayerViewModel(service: PlayerService()))
    }
}
