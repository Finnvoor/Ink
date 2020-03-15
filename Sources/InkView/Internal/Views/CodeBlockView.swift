//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct CodeBlockView: View {
    let text: String
    let options: MarkdownParser.ViewOptions
    
    var body: some View {
        HStack {
            if options.contains(.wrapsCodeBlock) {
                Text(self.text)
                    .font(.system(size: 14, design: .monospaced))
                    .padding()
                Spacer()
            } else {
                ScrollView(.horizontal) {
                    Text(self.text)
                        .font(.system(size: 14, design: .monospaced))
                }.padding()
            }
        }.background(Color(UIColor.secondarySystemBackground)).padding()
    }
}
