//
//  File.swift
//  
//
//  Created by Finn Voorhees on 15/03/2020.
//

import SwiftUI

internal struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

internal extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

internal extension Text {
    func strikethrough() -> Text {
        return self.strikethrough(true, color: .none)
    }
}
