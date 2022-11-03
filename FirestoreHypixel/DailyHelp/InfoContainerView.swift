//
//  InfoContainerView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 12/08/2022.
//

import SwiftUI

struct InfoContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InfoDetailView(title: "Accurate Stats", subTitle: "Your daily stats will now accurately be tracked and reset every day.", imageName: "checkmark.seal")

            InfoDetailView(title: "Check Anyone", subTitle: "You can start tracking anybody's daily stats now just by searching for their username.", imageName: "globe")

            
        }
        .padding(.horizontal)
    }
}

struct InfoContainerView_Previews: PreviewProvider {
    static var previews: some View {
        InfoContainerView()
    }
}
