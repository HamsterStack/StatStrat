//
//  DailyHelpView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 12/08/2022.
//

import SwiftUI

struct DailyHelpView: View {
    @Binding var helpShowing : Bool
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            VStack {
                
              

                Text("Welcome to")
                    .font(.largeTitle)
                            

                Text("Daily Stats")
                    .font(.largeTitle)
                    .foregroundColor(.bluePlus)
                Text("When you checked your stats just a second ago your daily stats started being tracked!")
                    .font(.title)
                    .foregroundColor(.bluePlus.opacity(0.5))
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                Text("Now every 24 hours your daily statistics will reset!")
                    .font(.title)
                    .foregroundColor(.bluePlus.opacity(0.5))
                    .padding(.horizontal)
                    .padding(.vertical, 3)
                
                            
                
                    }
            InfoContainerView() //
            Spacer(minLength: 30)
            
            Button {
                helpShowing.toggle()
            } label: {
                Text("Awesome!")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 30)
                        .fill(.bluePlus)
                    )
                    
                    .padding()
            }
                
            
            
            
            
        }
    }
}

