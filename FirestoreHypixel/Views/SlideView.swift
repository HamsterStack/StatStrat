//
//  SlideView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 06/08/2022.
//

import SwiftUI

struct SlideView: View {
    
    @Binding var darkModeOn : Bool
    @Binding var settingsOn: Bool
    @Binding var recentPlayersOn: Bool
    var body: some View {
        VStack{
            HStack{
                Text("Settings")
                    .padding()
                    .font(.title.bold())
                Spacer()
            }
            HStack{
                if settingsOn{
                    VStack(spacing: 0){
                        Toggle(isOn: $darkModeOn.animation(.spring())){
                            Label("Dark Mode", systemImage: "moon.circle")
                        }
                            .padding()
                        Toggle(isOn: $recentPlayersOn.animation(.interpolatingSpring(mass: 3, stiffness: 50, damping: 50, initialVelocity: 5))){
                            Label("Recent Users", systemImage: "person.crop.circle")
                        }
                            .padding()
                    }
                }
                
                Spacer()
            }
            Spacer()
        }
            
    }
}


