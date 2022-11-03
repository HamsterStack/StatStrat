//
//  ContentView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 31/07/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PlayerViewModel(service: PlayerService())
    
    var body: some View {
        LoginView(vm: vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
