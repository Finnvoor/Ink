//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct CodeBlockView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(self.text)
                .font(.system(size: 14, design: .monospaced))
                .padding()
            Spacer()
        }.background(Color(UIColor.secondarySystemBackground)).padding()
    }
}
