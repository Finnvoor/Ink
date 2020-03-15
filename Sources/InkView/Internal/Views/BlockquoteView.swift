//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import Foundation
import SwiftUI

internal struct BlockquoteView: View {
    let text: String
    @State private var textRect: CGRect = CGRect()
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 4, height: self.textRect.height)
            Text(self.text)
                .lineLimit(nil)
                .background(GeometryGetter(rect: self.$textRect))
        }.foregroundColor(.secondary).padding(.horizontal)
    }
}
