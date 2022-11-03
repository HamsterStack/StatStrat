//
//  TwoTextView.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

struct TwoTextView: View {
    
    let First : String
    let Second : String
    let Color : Color
    
    
    var body: some View {
        HStack{
            Text(First)
            Spacer()
            Text(Second)
                .foregroundColor(Color)
        }
    }
}


