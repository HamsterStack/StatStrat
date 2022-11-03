//
//  ViewModifiers.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 04/08/2022.
//

import SwiftUI

struct Center : ViewModifier{
    func body(content: Content) -> some View {
        HStack{
            Spacer()
            content
            Spacer()
        }
    }
    
    
}

extension View{
    func center() -> some View{
        modifier(Center())
    }
}
