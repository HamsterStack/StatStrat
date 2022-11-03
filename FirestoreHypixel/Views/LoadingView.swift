//
//  LoadingView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI




struct LoadingView: View {
    @State private var spinning = false
    var body: some View {
        ZStack{
            Color.gray
                .opacity(0.7)
                .ignoresSafeArea()
            Image("bedloading")
                .onAppear{
                    spinning.toggle()
                }
                .rotationEffect(.degrees(spinning ? 359 : 0))
                .animation(.linear(duration: 0.8)
                    .repeatForever(autoreverses: false), value: spinning)
                
                
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
