//
//  RankTextView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

struct RankTextView : View{
    @Environment(\.colorScheme) var isDarkMode
    
    
    
    var rankColorMap : [String: Color] =
    [ "LIGHT_PURPLE" : .lightPurplePlus,
      "RED" : .redPlus,
      "DARK_RED" : .darkRedPlus,
      "WHITE" : .grayPlus,
      "GOLD" : .goldPlus,
      "GREEN" : .greenPlus,
      "YELLOW" : .yellowPlus,
      "BLUE" : .bluePlus,
      "DARK_GREEN" : .darkGreenPlus,
      "DARK_AQUA" : .darkAquaPlus,
      "DARK_PURPLE" : .darkPurplePlus,
      "DARK_BLUE" : .darkBluePlus,
      "GREY" : .grayPlus,
      "BLACK" : .blackPlus
      
      
    
    ]
    var rankMap : [String : String] =
    [ "MVP_PLUS" : "MVP",
      "MVP" : "MVP",
      "VIP_PLUS" : "VIP",
      "VIP" : "VIP",
      "" : "" ]
    
    
    var username: String
    var rankColor : String
    var rank : String
    var mvpPlusPlus: Bool
    var body : some View{
        HStack(spacing: 0){
            if username=="hypixel"{
                Text("[OWNER] \(username)")
                    .foregroundColor(.redPlus) // eh.....
            }
            else if (mvpPlusPlus){
                //player has mvp++
                Text("[MVP")
                    .foregroundColor(.goldPlus)
                Text("++")
                    .foregroundColor(rankColorMap[rankColor] ?? .white)
                Text("] \(username)")
                    .foregroundColor(.goldPlus)
            }
            else if rank == "NONE"{
                Text("\(username)")
                    .foregroundColor(isDarkMode == .dark ? .white : .black) // eh....
            }
            else if rank != "" {
                Text("[\(rankMap[rank] ?? "")")
                    .foregroundColor((rank == "MVP" || rank == "MVP_PLUS") ? .aquaRank : .greenPlus)
                if rank == "MVP_PLUS" || rank=="VIP_PLUS"{
                    Text("+")
                        .foregroundColor(rankColorMap[rankColor] ?? .white)
                }
                Text("] \(username)")
                    .foregroundColor((rank == "MVP" || rank == "MVP_PLUS") ? .aquaRank : .greenPlus)
            }
            else{
                Text("\(username)")
                    .foregroundColor(isDarkMode == .dark ? .white : .black)
            }
            
            
           
           
            
        }
    }
}
