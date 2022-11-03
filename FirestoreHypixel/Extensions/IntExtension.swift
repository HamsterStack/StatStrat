//
//  IntExtension.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 12/08/2022.
//

import Foundation

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
