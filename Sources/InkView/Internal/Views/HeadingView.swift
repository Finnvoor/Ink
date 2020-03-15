//
//  HeadingView.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct HeadingView: View {
    let text: String
    
    var body: some View {
        Text(self.text)
            .font(.headline)
            .padding(.horizontal)
    }
}
