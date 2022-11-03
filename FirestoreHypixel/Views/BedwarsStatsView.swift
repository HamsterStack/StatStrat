//
//  BedwarsStatsView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 08/08/2022.
//

import SwiftUI

struct BedwarsStatsView: View {
    @ObservedObject var vm : PlayerViewModel
    @State private var prestigeOn = false
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
                    let finals = player.stats.Bedwars?.final_kills_bedwars ?? 0
                    let finaldeaths = player.stats.Bedwars?.final_deaths_bedwars ?? 0
                    let fkdr = player.stats.Bedwars?.fkdr ?? 0
                    let wins = player.stats.Bedwars?.wins_bedwars ?? 0
                    let losses = player.stats.Bedwars?.losses_bedwars ?? 0
                    let wlr = player.stats.Bedwars?.wlr
                    let star = player.achievements?.bedwars_level ?? 0
                    let stars = star.digits
                    
                    
                    HStack{
                        Text("Bedwars Level")
                        Spacer()
                        

                        HStack(spacing: 0){
                            if star<100{
                                Text("[\(star)✫]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<200{
                                Text("[\(star)✫]")
                                    .foregroundColor(.lightGray)
                            }
                            else if star<300{
                                Text("[\(star)✫]")
                                    .foregroundColor(.goldPlus)
                            }
                            else if star<400{
                                Text("[\(star)✫]")
                                    .foregroundColor(.aquaRank)
                            }
                            else if star<500{
                                Text("[\(star)✫]")
                                    .foregroundColor(.emeraldColor)
                            }
                            else if star<600{
                                Text("[\(star)✫]")
                                    .foregroundColor(.darkAquaPlus)
                            }
                            else if star<700{
                                Text("[\(star)✫]")
                                    .foregroundColor(.darkRedPlus)
                            }
                            else if star<800{
                                Text("[\(star)✫]")
                                    .foregroundColor(.lightPurplePlus)
                            }
                            else if star<900{
                                Text("[\(star)✫]")
                                    .foregroundColor(.bluePlus)
                            }
                            else if star<1000{
                                Text("[\(star)✫]")
                                    .foregroundColor(.darkPurplePlus)
                            }
                            else if star<1100{
                                
                                Text("[")
                                    .foregroundColor(.darkRedPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.goldPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.yellowColor)
                                    Text("\(stars[2])")
                                        .foregroundColor(.greenPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.aquaRank)
                                    Text("✫")
                                        .foregroundColor(.lightPurplePlus)
                                    Text("]")
                                        .foregroundColor(.darkPurplePlus)

                                    
                                }
                            }
                            else if star<1200{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)✪")
                                    .foregroundColor(.lightGray)
                                Text("]")
                                    .foregroundColor(.darkGray)
                                
                            }
                            else if star<1300{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.yellowPlus)
                                Text("✪")
                                    .foregroundColor(.goldPlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1400{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.aquaRank)
                                Text("✪")
                                    .foregroundColor(.darkAquaPlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1500{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.emeraldColor)
                                Text("✪")
                                    .foregroundColor(.darkGreenPlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1600{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.darkAquaPlus)
                                Text("✪")
                                    .foregroundColor(.darkBluePlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1700{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.redPlus)
                                Text("✪")
                                    .foregroundColor(.darkRedPlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1800{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.lightPurplePlus)
                                Text("✪")
                                    .foregroundColor(.darkPurplePlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<1900{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.bluePlus)
                                Text("✪")
                                    .foregroundColor(.darkBluePlus)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<2000{
                                Text("[")
                                    .foregroundColor(.darkGray)
                                Text("\(star)")
                                    .foregroundColor(.darkPurplePlus)
                                Text("✪")
                                    .foregroundColor(.darkGray)
                                Text("]")
                                    .foregroundColor(.darkGray)
                            }
                            else if star<2100{
                                Text("[")
                                    .foregroundColor(.black)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.darkGray)
                                    Text("\(stars[1])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[2])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkGray)
                                    Text("✫")
                                        .foregroundColor(.darkGray)
                                    Text("]")
                                        .foregroundColor(.black)

                                    
                                }
                            }
                            else if star<2200{
                                Text("[")
                                    .foregroundColor(.lightGray)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[1])")
                                        .foregroundColor(.yellowPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.yellowPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.goldPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.goldPlus)
                                    Text("]")
                                        .foregroundColor(.lightGray)
                                }
                            
                            }
                            else if star<2300{
                                Text("[")
                                    .foregroundColor(.goldPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.goldPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[2])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkAquaPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.darkAquaPlus)
                                    Text("]")
                                        .foregroundColor(.darkAquaPlus)
                                }
                            }
                            else if star<2400{
                                Text("[")
                                    .foregroundColor(.darkPurplePlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.darkPurplePlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.lightPurplePlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.lightPurplePlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.goldPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.goldPlus)
                                    Text("]")
                                        .foregroundColor(.goldPlus)
                                }
                            }
                            else if star<2500{
                                Text("[")
                                    .foregroundColor(.aquaRank)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.aquaRank)
                                    Text("\(stars[1])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[2])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkGray)
                                    Text(String("❀"))
                                        .foregroundColor(.darkGray)
                                    Text("]")
                                        .foregroundColor(.darkGray)
                                }
                            }
                            else if star<2600{
                                Text("[")
                                    .foregroundColor(.lightGray)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[1])")
                                        .foregroundColor(.greenPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.greenPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkGreenPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.darkGreenPlus)
                                    Text("]")
                                        .foregroundColor(.darkGreenPlus)
                                }
                            }
                            else if star<2700{
                                Text("[")
                                    .foregroundColor(.darkRedPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.darkRedPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.redPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.redPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.lightPurplePlus)
                                    Text(String("❀"))
                                        .foregroundColor(.lightPurplePlus)
                                    Text("]")
                                        .foregroundColor(.darkPurplePlus)
                                }
                            }
                            else if star<2800{
                                Text("[")
                                    .foregroundColor(.goldPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.goldPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[2])")
                                        .foregroundColor(.lightGray)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkGray)
                                    Text(String("❀"))
                                        .foregroundColor(.darkGray)
                                    Text("]")
                                        .foregroundColor(.darkGray)
                                }
                            }
                            else if star<2900{
                                Text("[")
                                    .foregroundColor(.greenPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.greenPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.darkGreenPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.darkGreenPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.goldPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.goldPlus)
                                    Text("]")
                                        .foregroundColor(.yellowPlus)
                                }
                            }
                            else if star<3000{
                                Text("[")
                                    .foregroundColor(.aquaRank)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.aquaRank)
                                    Text("\(stars[1])")
                                        .foregroundColor(.darkAquaPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.darkAquaPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.bluePlus)
                                    Text(String("❀"))
                                        .foregroundColor(.bluePlus)
                                    Text("]")
                                        .foregroundColor(.darkBluePlus)
                                }
                            }
                            else if star<3100{
                                Text("[")
                                    .foregroundColor(.yellowPlus)
                                if stars.count == 4{
                                    Text("\(stars[0])")
                                        .foregroundColor(.yellowPlus)
                                    Text("\(stars[1])")
                                        .foregroundColor(.goldPlus)
                                    Text("\(stars[2])")
                                        .foregroundColor(.goldPlus)
                                    Text("\(stars[3])")
                                        .foregroundColor(.darkRedPlus)
                                    Text(String("❀"))
                                        .foregroundColor(.darkRedPlus)
                                    Text("]")
                                        .foregroundColor(.darkRedPlus)
                                }
                            }
                            else{
                                Text("[\(star)✫]")
                                    .foregroundColor(.black)
                                
                            }
                                        
                        }
                       
                        
                        
                    }
                    TwoTextView(First: "Final Kills⚔️", Second: "\(finals)", Color: Color.blue)
                    TwoTextView(First: "Final Deaths💀 ", Second: "\(finaldeaths)", Color: Color.blue)
                    TwoTextView(First: "FKDR⚔️", Second: "\(String(format: "%.2f", fkdr))", Color: Color.blue)
                    TwoTextView(First: "Wins⚔️ ", Second: "\(wins)", Color: Color.blue)
                    TwoTextView(First: "Losses💀 ", Second: "\(losses)", Color: Color.blue)
                    TwoTextView(First: "WLR", Second: "\(String(format: "%.2f", wlr ?? 0))", Color: Color.blue)
                    TwoTextView(First: "Void Deaths💀 ", Second: "\(player.stats.Bedwars?.void_deaths_bedwars ?? 0)", Color: Color.blue)
                    
                }
                
                if player.stats.Bedwars?.playerShop.count ?? 0 > 0 && player.stats.Bedwars?.favourites_2 != nil{
                    Section("Item Shop"){
                        ScrollView(.horizontal){
                            
                            
                            ShopView(items: player.stats.Bedwars?.playerShop ?? [""])
                                .padding()
                        }
                    
                        
                    }
                }
               
                
                
                
                
            }
            
            .padding(.vertical, -30) //removable we will see.
            
           
        default:
            EmptyView()
        }
    }
}


