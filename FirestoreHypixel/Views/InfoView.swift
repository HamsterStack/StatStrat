//
//  InfoView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 05/08/2022.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack
        {
            HStack{
                Text("This app is powered by the [Hypixel API](https://api.hypixel.net/)")
                    .padding()
                
                Spacer()
            }
            HStack{
                Text("To report bug fixes or suggest new features you can contact the developer at statstrathelp@gmail.com")
                   
                    .padding(.horizontal)
                
                Spacer()
                
            }
            
            Spacer()
            HStack{
                Text("StatStrat is not affiliated with Hypixel™. StatStrat is not an official Minecraft product. Not approved by or associated with Mojang.")
                    .font(.caption)
                    .foregroundColor(colorScheme == .light ? .black.opacity(0.6) : .white.opacity(0.5))
                    .padding()
                    
                
                Spacer()
            }
        }
        .navigationTitle("Information")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
