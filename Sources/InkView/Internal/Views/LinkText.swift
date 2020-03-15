//
//  LinkText.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

struct LinkText: View {
    var text: String
    var url: String
    
    var body: some View {
        Text(self.text)
            .onTapGesture {
                print("tapped \(self.url)")
            }
    }
}
