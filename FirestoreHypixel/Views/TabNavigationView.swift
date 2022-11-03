//
//  TabNavigationView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

import SwiftUI

struct TabNavigationView: View {
    @ObservedObject var vm: PlayerViewModel
    @State private var selection = "Profile"
    @State private var title = "Profile"
    
    var body: some View {
        TabView(selection: $selection){
            
            
            ProfileView(vm: vm)
                .tabItem{
                    Text("Profile")
                }
                .tag("Profile")
                
                
                
            DailyView(vm: vm)
                .tabItem{
                    Button("Daily") {
                        
                    }
                }
                .tag("Daily")
            
            
        }
        .tabViewStyle(.page)
        
        .onChange(of: selection) { _ in
            if selection == "Profile"{
                title = "Profile"
            }
            else{
                title = "Daily"
            }
        }
        .toolbar{
            ToolbarItem(placement: .principal){
                Text(title)
            }
        }
    }
}
