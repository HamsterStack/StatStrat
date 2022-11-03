//
//  ShopView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 14/08/2022.
//

import SwiftUI
extension Image{
    func minecraftIcon() -> some View {
        self
            .resizable()
            .frame(width: 40, height: 40)
            
    }
}
struct ShopView: View {
    let items : [String]
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        let columns = [GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40)), GridItem(.fixed(40))]
        
        LazyVGrid(columns: columns){
            ForEach(items, id: \.self) { item in
                if item == "null"{
                    Text("Empty")
                        .font(.caption)
                        .frame(width: 40, height: 40)
                        .border(colorScheme == .dark ? .white : .black)
                }
                else{
                    Image(item)
                        .minecraftIcon()
                        .border(colorScheme == .dark ? .white : .black)
                    
                }
                
            }
        }
        
        
        
    }
}

