//
//  DatabaseExtensions.swift
//  FirestoreHypixel
//
//  Created by Tom Miller on 01/08/2022.
//

import Foundation
import FirebaseFirestore
extension Firestore{
    
    func newPlayerDocument<T>(data: [String: T], username : String, uuid : String){
        /// Creates new player document in players collection with data as document ID and data as the data for that document.
        /// - Parameters:
        ///   - data: data for the document
        ///   - username: document id
        collection("players").document(username).setData(data)
        collection("players").document(username).setData(["registerDate" : Date.now], merge: true)
        collection("players").document(username).setData(["uuid" : uuid], merge: true)
        
        
        
    }
}

