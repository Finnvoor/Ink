//
//  HorizontalLineView.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct HorizontalLineView: View {
    var body: some View {
        Rectangle()
            .frame(height: 6)
            .foregroundColor(.secondary)
            .padding(.horizontal)
    }
}
