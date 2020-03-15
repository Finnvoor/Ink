//
//  HeadingView.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct HeadingView: View {
    let text: String
    let level: Int
    
    var body: some View {
        Text(self.text)
            .fontForLevel(level: self.level)
            .padding(.horizontal)
    }
}

internal extension Text {
    func fontForLevel(level: Int) -> Text {
        switch level {
        case 1:
            return self.font(.system(size: 34, weight: .semibold))
        case 2:
            return self.font(.system(size: 28, weight: .semibold))
        case 3:
            return self.font(.system(size: 22, weight: .semibold))
        case 4:
            return self.font(.system(size: 20, weight: .semibold))
        case 5:
            return self.font(.headline)
        case 6:
            return self.font(.headline).foregroundColor(.secondary)
        default:
            return self.font(.body)
        }
    }
}
